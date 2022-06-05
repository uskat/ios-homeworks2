
import UIKit

class PhotosViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()
    var photos = Photo.addPhotos()
    
    
//MARK: ==================================== INITs ====================================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Photo Gallery"
        view.backgroundColor = .systemGray6
        showCollection()
    }
    
    override func viewWillLayoutSubviews() {
        self.navigationController?.isNavigationBarHidden = false
        checkOrientation()
    }
    
    
//MARK: ================================== ViewITEMs ==================================
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collection
    }()
    
    private func showCollection() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    let buttonX: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 12
        $0.backgroundColor = UIColor.AccentColor.normal //.systemGray
        $0.setImage(UIImage(systemName: "x.circle"), for: .normal)
        $0.tintColor = .white
        $0.alpha = 0.0
        $0.isHidden = true
        $0.addTarget(self, action: #selector(tapButtonX), for: .touchUpInside)
        return $0
    }(UIButton())
    @objc private func tapButtonX() {
        print("tap x")
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut) { [self] in
            self.buttonX.alpha = 0.0
        } completion: { _ in
            self.buttonX.isHidden = true
        }
        UIView.transition(with: collectionView, duration: 1.0, options: .transitionFlipFromBottom, animations: { [self] in
            profileHeaderView.blurBackgroundEffect().removeFromSuperview()
            collectionView.isUserInteractionEnabled = true
            myView.removeFromSuperview()
        }, completion: nil)
    }
    
    private var myImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .none
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private var myView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    func showViewWithPhotoOnTap(_ image: UIImage)  {
        UIView.transition(with: collectionView, duration: 3.0, options: .transitionFlipFromBottom, animations: { [self] in
            collectionView.addSubview(myView)
            myView.addSubview(profileHeaderView.blurBackgroundEffect())
            myImageView.image = image
            myView.addSubview(myImageView)
            myView.addSubview(buttonX)
            NSLayoutConstraint.activate([
                myView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                myView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                myView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                myView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
                
                myImageView.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
                myImageView.centerYAnchor.constraint(equalTo: myView.centerYAnchor),
                myImageView.widthAnchor.constraint(equalToConstant: absoluteWidth),
                myImageView.heightAnchor.constraint(equalToConstant: absoluteWidth),
                
                buttonX.topAnchor.constraint(equalTo: myView.topAnchor, constant: 20),
                buttonX.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -20),
                buttonX.widthAnchor.constraint(equalToConstant: 24),
                buttonX.heightAnchor.constraint(equalToConstant: 24)
            ])
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut) { [self] in
            self.buttonX.isHidden = false
            self.buttonX.alpha = 1.0
        } completion: { _ in  }
    }
}

//MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell(photos[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var inSpace: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (absoluteWidth - 4 * inSpace) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        inSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inSpace, left: inSpace, bottom: inSpace, right: inSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = photos[indexPath.row].imageName
        showViewWithPhotoOnTap(image)
    }
}

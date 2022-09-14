
import UIKit

class DetailedPostViewController: UIViewController {

    var index: IndexPath?
    var post: Post?
    weak var delegate: AddLikeDelegate?
    
    private var heartWidth = NSLayoutConstraint()
    private var heartHeight = NSLayoutConstraint()
    
    let profileTVCell = ProfileTableViewCell()

//MARK: ==================================== INITs ====================================
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        show()
        setupLikesGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarUIView?.backgroundColor = .none
    }

    override func viewDidDisappear(_ animated: Bool) {
        checkOrientation()
    }

    
//MARK: ================================== ViewITEMs ==================================
    let postName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    let postDescription: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .systemGray
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    let postImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let likes: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.isUserInteractionEnabled = true
        return $0
    }(UILabel())
    
    let views: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
        $0.textAlignment = .right
        return $0
    }(UILabel())

    let buttonX: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 12
        $0.backgroundColor = UIColor.AccentColor.normal
        $0.setImage(UIImage(systemName: "x.circle"), for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(tapButtonX), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc private func tapButtonX() {
        print("tap x")
        self.dismiss(animated: true)
    }
    
    private let heart: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.alpha = 0.0
        $0.image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .systemRed))
        return $0
    }(UIImageView())
    
    func show() {
        [postName, postDescription, postImage, likes, views, buttonX, heart].forEach({ view.addSubview($0) })
        
        heartWidth = heart.widthAnchor.constraint(equalToConstant: 24)
        heartHeight = heart.heightAnchor.constraint(equalToConstant: 24)
        
        NSLayoutConstraint.activate([
            postName.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            postName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            postName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //postName.heightAnchor.constraint(equalToConstant: 20)

            postImage.topAnchor.constraint(equalTo: postName.bottomAnchor, constant: 12),
            postImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: absoluteWidth),

            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.leadingAnchor.constraint(equalTo: postName.leadingAnchor),
            postDescription.trailingAnchor.constraint(equalTo: postName.trailingAnchor),

            likes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            likes.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            likes.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            views.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            views.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            views.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            heart.centerXAnchor.constraint(equalTo: postImage.centerXAnchor, constant: 0),
            heart.centerYAnchor.constraint(equalTo: likes.centerYAnchor, constant: 0),
            heartWidth, heartHeight,
            
            buttonX.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            buttonX.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonX.widthAnchor.constraint(equalToConstant: 24),
            buttonX.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
//MARK: =================================== METHODs ===================================
    func setupLikesGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapLike))
        likes.addGestureRecognizer(tapGesture)
    }
    @objc private func tapLike (){
        if let index = index { delegate?.addLike(index, "Detail") }
        if let post = post {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut) { [self] in
                heart.alpha = 1.0
                heartWidth.constant = 64
                heartHeight.constant = 64
                self.view.layoutIfNeeded()
            } completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0.05, options: .curveEaseIn) { [self] in
                    heartWidth.constant = 24
                    heartHeight.constant = 24
                    heart.alpha = 0.0
                    self.view.layoutIfNeeded()
                } completion: { _ in  }
            }
            
            likes.text = "Likes: \(post.likes)"
        }
    }
    
    func setupCell(_ post: Post) {
        postName.text = post.author
        postImage.image = post.imageName
        postDescription.text = post.description
        likes.text = "Likes: \(post.likes)"
        views.text = "Views: \(post.views)"
    }
}

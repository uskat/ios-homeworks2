
import UIKit

class ProfileViewController: UIViewController {

    private let profileHeaderView = ProfileHeaderView()
    private let profileTableViewCell = ProfileTableViewCell()
    private var posts: [Post] = Post.addPosts()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        showProfileTable()
        tapGestureOnProfileImage()
    }
    
    override func viewWillLayoutSubviews() {
        checkOrientation()
    }
    
    //private func showHeaderView() {
        //view.addSubview(profileView)
        //profileView.showProfileHeaderView()
        //profileView.translatesAutoresizingMaskIntoConstraints = false
        
        /*NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            profileView.heightAnchor.constraint(equalToConstant: 220)
        ])*/
    //}
   
    //MARK: bottom part of ProfileView ====================================================================================

    
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        $0.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    private func showProfileTable() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    //MARK: жесты и анимация
    
    func tapGestureOnProfileImage() {
        print("tapGesture?")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        bottomBlurView.constant = screenHeight
        profileHeaderView.blurView.setNeedsUpdateConstraints()
        profileHeaderView.profileImage.addGestureRecognizer(tapGesture)
    }

    @objc private func tapAction() {
        print("tap")
        tableView.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut) { [self] in
            centerXProfileImage = profileHeaderView.profileImage.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor) //screenWidth / 2
            centerYProfileImage = profileHeaderView.profileImage.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor) //screenHeight / 2 - 80 //magic number для корректировки вертикальности
            widthProfileImage.constant = absoluteWidth
            heightProfileImage.constant = absoluteWidth
            profileHeaderView.profileImage.layer.cornerRadius = 0
            profileHeaderView.blurView.alpha = 1.0
            view.setNeedsUpdateConstraints()
            profileHeaderView.profileImage.setNeedsUpdateConstraints()
        } completion: { _ in
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut) { [self] in
            profileHeaderView.buttonX.isHidden = false
            profileHeaderView.buttonX.alpha = 1.0
        } completion: { _ in  }}
    }
    
    func tapGestureOnLikes() {
        print("tapGestureOnLikes?")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapActionOnLikes))
        profileTableViewCell.likes.addGestureRecognizer(tapGesture)
    }

    @objc private func tapActionOnLikes() {
        print("tapOnLikes")
        
    }
    
    private var choosenPostView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        //$0.backgroundColor = .white
        //$0.isUserInteractionEnabled = true
        return $0
    }(UIView())
    
    func showChoosenPostView(_ post: Post)  {
        profileTableViewCell.setupCell(post)
        UIView.transition(with: tableView, duration: 1.0, options: .transitionFlipFromBottom, animations: { [self] in
            self.tableView.addSubview(choosenPostView)
            choosenPostView.addSubview(profileHeaderView.blurBackgroundEffect())
            [profileTableViewCell.postName, profileTableViewCell.postImage, profileTableViewCell.postDescription, profileTableViewCell.likes, profileTableViewCell.views].forEach({ choosenPostView.addSubview($0) })
            
            NSLayoutConstraint.activate([
                choosenPostView.topAnchor.constraint(equalTo: view.topAnchor),
                choosenPostView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                choosenPostView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                choosenPostView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                profileTableViewCell.postName.topAnchor.constraint(equalTo: choosenPostView.topAnchor, constant: 16),
                profileTableViewCell.postName.leadingAnchor.constraint(equalTo: choosenPostView.leadingAnchor, constant: 16),
                profileTableViewCell.postName.trailingAnchor.constraint(equalTo: choosenPostView.trailingAnchor, constant: -16),
                //postName.heightAnchor.constraint(equalToConstant: 20)

                profileTableViewCell.postImage.topAnchor.constraint(equalTo: profileTableViewCell.postName.bottomAnchor, constant: 12),
                profileTableViewCell.postImage.leadingAnchor.constraint(equalTo: choosenPostView.leadingAnchor),
                profileTableViewCell.postImage.trailingAnchor.constraint(equalTo: choosenPostView.trailingAnchor),
                profileTableViewCell.postImage.heightAnchor.constraint(equalToConstant: absoluteWidth),

                profileTableViewCell.postDescription.topAnchor.constraint(equalTo: profileTableViewCell.postImage.bottomAnchor, constant: 16),
                profileTableViewCell.postDescription.leadingAnchor.constraint(equalTo: profileTableViewCell.postName.leadingAnchor),
                profileTableViewCell.postDescription.trailingAnchor.constraint(equalTo: profileTableViewCell.postName.trailingAnchor),
                profileTableViewCell.postDescription.heightAnchor.constraint(equalToConstant: 100),

                profileTableViewCell.likes.topAnchor.constraint(equalTo: profileTableViewCell.postDescription.bottomAnchor, constant: 16),
                profileTableViewCell.likes.leadingAnchor.constraint(equalTo: choosenPostView.leadingAnchor, constant: 16),
                profileTableViewCell.likes.trailingAnchor.constraint(equalTo: choosenPostView.trailingAnchor, constant: -16),
                profileTableViewCell.likes.bottomAnchor.constraint(equalTo: choosenPostView.bottomAnchor, constant: -16),
                
                profileTableViewCell.views.topAnchor.constraint(equalTo: profileTableViewCell.postDescription.bottomAnchor, constant: 16),
                profileTableViewCell.views.leadingAnchor.constraint(equalTo: choosenPostView.leadingAnchor, constant: 16),
                profileTableViewCell.views.trailingAnchor.constraint(equalTo: choosenPostView.trailingAnchor, constant: -16),
                profileTableViewCell.views.bottomAnchor.constraint(equalTo: choosenPostView.bottomAnchor, constant: -16)

            ])
        })
    }
}
    
//MARK: UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(#function)
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        var context: UIListContentConfiguration = cell.defaultContentConfiguration()
//        context.text = "что творится? \(indexPath.section), ячейка = \(indexPath.row)"
//        context.image = posts[indexPath.row].imageName
//        cell.contentConfiguration = context
//        return cell
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            //cell.setupCell(posts[1])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
            cell.setupCell(posts[indexPath.row - 1])
            return cell
        }
    }
}

//MARK: высота ячейки в таблице.
//Либо фиксированное значение, либо авто - UITableView.automaticDimension
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
//MARK: устанавливаем HEADER для таблицы !
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return profileHeaderView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        240
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let post = PhotosViewController()
            //navigationController?.pushViewController(post, animated: true)
            
            //анимированный push-переход с эффектом fade из Photos в Photo Galery
            let transition = CATransition()
            transition.duration = 2.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            transition.subtype = CATransitionSubtype.fromTop
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(post, animated: false)
        } else {
            showChoosenPostView(posts[indexPath.row])
        }
    }
}


/*
//MARK: Log out Button in NavagationBar ===============================================================================
private func showLogoutBarButton() {
    let button = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(tapLogoutBarButton))
    navigationItem.rightBarButtonItem = button
}
@objc private func tapLogoutBarButton() {
    self.dismiss(animated: true)
}*/


//MARK: разные виды анимации

//увеличение фото на весь экран (без движения)

//let newImageView = UIImageView(image: myView.image)
//newImageView.frame = UIScreen.main.bounds
//newImageView.backgroundColor = .black
//newImageView.contentMode = .scaleAspectFit
//newImageView.isUserInteractionEnabled = true
////let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
////newImageView.addGestureRecognizer(tap)
//self.view.addSubview(newImageView)
//self.navigationController?.isNavigationBarHidden = true
//self.tabBarController?.tabBar.isHidden = true

/*@objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
    self.navigationController?.isNavigationBarHidden = false
    self.tabBarController?.tabBar.isHidden = false
    sender.view?.removeFromSuperview()
}*/


//Код BlurEffect

//    private func addBlurEffect() {
//        let blurEffect = UIBlurEffect(style: .dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.alpha = 0.85
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(blurEffectView)
//
//        NSLayoutConstraint.activate([
//            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
//            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//      }

// Первая версия анимации открытия аватарки
/*
let sizeScale = CABasicAnimation(keyPath: "transform.scale")
sizeScale.fromValue = 1
sizeScale.toValue = absoluteWidth / 140

let positionAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
positionAnimation.fromValue = myView.centerYAnchor
positionAnimation.toValue = CGPoint(x: view.center.x, y: view.center.y - 70)

let group = CAAnimationGroup()
group.duration = 0.5
group.animations = [sizeScale, positionAnimation]
group.timingFunction = CAMediaTimingFunction(name: .easeIn)
group.fillMode = .forwards                                  //запрет возврата анимации в исходное положение
group.isRemovedOnCompletion = false                         //запрет возврата анимации в исходное положение
myView.layer.add(group, forKey: nil)
//myView.layer.position = CGPoint(x: view.center.x, y: view.center.y - 70)*/

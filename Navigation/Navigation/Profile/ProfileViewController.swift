
import UIKit

class ProfileViewController: UIViewController {
    
    private let sceneDelegate = SceneDelegate()
    private var profileHeaderView = ProfileHeaderView()
    private var posts: [Post] = Post.addPosts()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        showProfileTable()
    }
    
    override func viewWillLayoutSubviews() {
        //sceneDelegate.checkOrientation()
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
}
//MARK: UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(#function)
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        var context: UIListContentConfiguration = cell.defaultContentConfiguration()
//        context.text = "что творится? \(indexPath.section), ячейка = \(indexPath.row)"
//        context.image = posts[indexPath.row].imageName
//        cell.contentConfiguration = context
//        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        cell.setupCell(posts[indexPath.row])
        return cell
    }
}
//MARK: высота ячейки (строки) в таблице. Либо фиксированное значение, либо авто - UITableView.automaticDimension
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
//MARK: устанавливаем HEADER для нашей таблицы !!!
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //profileHeaderView.showProfileHeaderView()
        return profileHeaderView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        240
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


import UIKit

class ProfileViewController: UIViewController {
    
    private let sceneDelegate = SceneDelegate()
    private var profileView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        showHeaderView()
        showNewButton()
    }
    
    override func viewWillLayoutSubviews() {
        sceneDelegate.checkOrientation()
    }
    
    private func showHeaderView() {
        view.addSubview(profileView)
        profileView.showProfileHeaderView()
        profileView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            profileView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    //MARK: Log out Button in NavagationBar ===============================================================================
    private func showLogoutBarButton() {
        let button = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(tapLogoutBarButton))
        navigationItem.rightBarButtonItem = button
    }
    @objc private func tapLogoutBarButton() {
        self.dismiss(animated: true)
    }
    
    //MARK: bottom part of ProfileView ====================================================================================
    private let newButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("New button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Do nothing", for: .highlighted)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.addTarget(self, action: #selector(tapNewButton), for: .touchUpInside)
        return button
    }()
    @objc private func tapNewButton() {
        print("О, даааа! Я ничего не умею, но нажми на меня еще раз!")
    }
    
    private func showNewButton() {
        view.addSubview(newButton)
        
        NSLayoutConstraint.activate([
            newButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


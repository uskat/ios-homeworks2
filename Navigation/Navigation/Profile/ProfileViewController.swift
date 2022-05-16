
import UIKit

class ProfileViewController: UIViewController {
    
    private let sceneDelegate = SceneDelegate()
    private var profileView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
    }
 
    override func viewWillLayoutSubviews() {
        showHeaderView()
        showNewButton()
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
    
    private let newButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.setTitle("New button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Do nothing", for: .highlighted)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.addTarget(self, action: #selector(tapNewButton), for: .touchUpInside)
        //button.layer.shadowOffset = CGSize(width: 4, height: 4)
        //button.layer.shadowRadius = 4
        //button.layer.shadowColor = UIColor.black.cgColor
        //button.layer.shadowOpacity = 0.7
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


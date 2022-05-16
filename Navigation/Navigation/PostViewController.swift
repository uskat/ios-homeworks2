
import UIKit

class PostViewController: UIViewController {
    
    private let sceneDelegate = SceneDelegate()
    var post: FeedViewController.Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        showBarButton()
        if let post = post {
            title = post.title
        }
    }
 
    override func viewWillLayoutSubviews() {
        sceneDelegate.checkOrientation()
    }

    private func showBarButton() {
        let button = UIBarButtonItem(title: "Info...", style: .plain, target: self, action: #selector(tapAction))
        navigationItem.rightBarButtonItem = button
    }
    @objc private func tapAction() {
        let forthVC = InfoViewController()
        present(forthVC, animated: true)
    }
}

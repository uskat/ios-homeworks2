
import UIKit

class PostViewController: UIViewController {
    
    var post: FeedViewController.Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        makeBarButton()
        if let post = post {
            title = post.title
        }

    }
    private func makeBarButton() {
        let button = UIBarButtonItem(title: "Info...", style: .plain, target: self, action: #selector(tapAction))
        navigationItem.rightBarButtonItem = button
    }
    @objc private func tapAction() {
        let forthVC = InfoViewController()
        present(forthVC, animated: true)
    }
}

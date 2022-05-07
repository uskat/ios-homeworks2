
import UIKit

class FeedViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        makeButton()
    }

    struct Post {
        var title: String
    }
    private let newPost = Post(title: "Post")
    
    private func makeButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        button.layer.cornerRadius = 10
        button.center = view.center
        button.backgroundColor = .systemBlue
        button.setTitle("New Post", for: .normal)
        button.setTitle("Post opening...", for: .highlighted)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func tapButton() {
        let thirdVC = PostViewController()
        thirdVC.post = newPost
        navigationController?.pushViewController(thirdVC, animated: true)
        
    }
    

    
}


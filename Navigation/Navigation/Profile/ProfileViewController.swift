
import UIKit

class ProfileViewController: UIViewController {
    
    private var profileView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
 
    override func viewWillLayoutSubviews() {
        view.addSubview(profileView)
        profileView.frame = view.frame
        profileView.settings()
        view.addSubview(profileView.showImage())
        view.addSubview(profileView.showTitle())
        view.addSubview(profileView.showButton())
        view.layer.addSublayer(profileView.showShadowOfButton())
        view.addSubview(profileView.showStatus())
        view.addSubview(profileView.editStatusField())
        view.addSubview(profileView.showAcceptStatusButton())
    }
}

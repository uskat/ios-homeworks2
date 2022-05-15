
import UIKit

class MainTabBarController: UITabBarController {

    let firstVC = FeedViewController()
    let secondVC = ProfileViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupControllers()
        
    }
    
    private func setupControllers () {
        firstVC.tabBarItem.title = "Feed"
        firstVC.tabBarItem.image = UIImage(systemName: "rectangle.grid.2x2")
        firstVC.navigationItem.title = "Feed"
        secondVC.tabBarItem.title = "Profile"
        secondVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        secondVC.navigationItem.title = "Profile"
        let firstNavigationVC = UINavigationController(rootViewController: firstVC)
        let secondNavigationVC = UINavigationController(rootViewController: secondVC)
        //viewControllers = [firstVC, secondVC]
        viewControllers = [firstNavigationVC, secondNavigationVC]
        
        
    }
}

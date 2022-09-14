
import UIKit

class MainTabBarController: UITabBarController {

    let firstVC = FeedViewController()
    var secondVC = ProfileViewController()
    
    func findNavigationBarHeight() -> Int {
        if let k = secondVC.navigationController?.navigationBar.frame.height {
            return Int(k) //k2
        } else { return 0 }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        //вычисляем высоту NavigationBar и StatusBar для сдвига элементов Profile
        let appDelegate = AppDelegate()
        AppDelegate.topBarHeight = findNavigationBarHeight() + appDelegate.findStatusBarHeight()
        UINavigationBar.appearance().backgroundColor = UIColor.gray
        //UIBarButtonItem.appearance().tintColor = UIColor.magenta
        UITabBar.appearance().backgroundColor = UIColor.gray
    }
 
    private func setupControllers() {
        firstVC.tabBarItem.title = "Feed"
        firstVC.tabBarItem.image = UIImage(systemName: "rectangle.grid.2x2")
        firstVC.navigationItem.title = "Feed"
        secondVC.tabBarItem.title = "Profile"
        secondVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        secondVC.navigationItem.title = "Profile"
        let firstNavigationVC = UINavigationController(rootViewController: firstVC)
        let secondNavigationVC = UINavigationController(rootViewController: secondVC)
        viewControllers = [firstNavigationVC, secondNavigationVC]
    }
}

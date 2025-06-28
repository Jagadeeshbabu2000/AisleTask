import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .lightGray
        selectedIndex = 1
    }
    
}

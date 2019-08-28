import UIKit
extension UIViewController {
    /**
     *Allows any view/button navigate to another View*
     - Parameters:
        - target: The target view to go
     - returns: Nothing
     */
    func fadeNavigation(target: UIViewController) {
        let goVC = target
        goVC.modalPresentationStyle = .custom
        goVC.modalTransitionStyle = .crossDissolve
        self.present(goVC, animated: true, completion: nil)
    }
}

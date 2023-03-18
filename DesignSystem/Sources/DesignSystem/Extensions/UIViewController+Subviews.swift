import UIKit

extension UIViewController {
  public func addChildViewControllerToSelf(_ vc: UIViewController) {
    view.addSubview(vc.view)
    addChild(vc)
    vc.didMove(toParent: self)
  }
}

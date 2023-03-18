import UIKit
import DesignSystem


class SpinnerViewController: UIViewController {
  var spinner = UIActivityIndicatorView(style: .large)
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = UIColor(white: 0, alpha: 0.7)
    
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.startAnimating()
    view.addSubview(spinner)
    
    spinner.center(in: view)
  }
}

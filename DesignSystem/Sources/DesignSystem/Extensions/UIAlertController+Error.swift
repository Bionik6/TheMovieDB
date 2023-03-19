import UIKit
import Domain
import Foundation


extension UIAlertController {
  public convenience init<Error: LocalizedError>(_ error: Error, preferredStyle: UIAlertController.Style) {
    let title = error.errorDescription
    let message = [
      error.failureReason,
      error.recoverySuggestion
    ].compactMap { $0 }
      .joined(separator: "\n\n")
    
    self.init(title: title, message: message, preferredStyle: preferredStyle)
  }
}

extension UIViewController {
  public func show(error: LocalizedError) {
    let alertController = UIAlertController(error, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(action)
    present(alertController, animated: true)
  }
}


extension UIViewController {
  public func showInfo(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(action)
    present(alertController, animated: true)
  }
}

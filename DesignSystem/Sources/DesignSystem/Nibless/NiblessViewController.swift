import UIKit
import Domain
import Combine

open class NiblessViewController: UIViewController {
  
  // MARK: - Methods
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable,
              message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
  )
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  @available(*, unavailable,
              message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
  )
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
  }
  
  
  public func handleErrorIfAny(_ error: Published<LocalizedError?>.Publisher, cancellables: inout Set<AnyCancellable>) {
    error
      .receive(on: DispatchQueue.main)
      .sink { [weak self] error in
        guard let error, let self else { return }
        self.show(error: error)
      }.store(in: &cancellables)
  }
  
  
  public func handleLoading(_ isLoading: Published<Bool>.Publisher, cancellables: inout Set<AnyCancellable>) {
    isLoading
      .receive(on: DispatchQueue.main)
      .sink { [weak self] isLoading in
        guard let self else { return }
        if isLoading { self.showLoadingIndicator() }
        if !isLoading { self.hideLoadingIndicator() }
      }.store(in: &cancellables)
  }
  
  private func showLoadingIndicator() {
    MovieDBActivityIndicator.showAdded(
      to: view,
      title: "Please wait",
      message: "Please wait while we retrieve from the server"
    )
  }
  
  private func hideLoadingIndicator() {
    MovieDBActivityIndicator.hide(for: view)
  }
  
}

import UIKit
import Domain
import MoviesFeature


final class AppCoordinator {
  
  private let navigationController: UINavigationController
  
  private lazy var moviesListVC: MoviesListViewController = {
    let useCase = GetMoviesUseCase(repository: <#T##MovieRepository#>)
    let model = MoviesListViewModel(useCase: useCase)
    let viewController = MoviesListViewController(model: model)
    viewController.delegate = self
    return viewController
  }()
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    navigationController.pushViewController(moviesListVC, animated: false)
  }
}


extension AppCoordinator: MoviesListViewControllerDelegate {
  func didSelect(movie: Movie) {
    let vc = UIViewController()
    vc.view.backgroundColor = .red
    navigationController.pushViewController(vc, animated: true)
  }
}

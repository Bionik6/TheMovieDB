import UIKit
import Data
import Domain
import MoviesFeature


final class AppCoordinator {
  private let navigationController: UINavigationController
  
  private lazy var moviesListVC: MoviesListViewController = {
    let useCase = GetMoviesUseCase(repository: DefaultMovieRepository())
    let model = MoviesListViewModel(useCase: useCase)
    let vc = MoviesListViewController(model: model)
    vc.delegate = self
    return vc
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
    let useCase = GetMovieDetailsUseCase(movie: movie, repository: DefaultMovieRepository())
    let model = MovieDetailsViewModel(useCase: useCase)
    let vc = MovieDetailsViewController(model: model)
    navigationController.pushViewController(vc, animated: true)
  }
}

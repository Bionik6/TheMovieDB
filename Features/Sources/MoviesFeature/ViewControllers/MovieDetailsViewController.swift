import UIKit
import Domain
import Combine
import DesignSystem


public class MovieDetailsViewController: NiblessViewController {
  private let model: MovieDetailsViewModel
  private var cancellables = Set<AnyCancellable>()
  
  public init(model: MovieDetailsViewModel) {
    self.model = model
    super.init()
  }
  
  public override func loadView() {
    self.view = MovieDetailsView()
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupObservers()
    Task { await model.fetchMovieDetails() }
  }
  
  private func setupView() {
    navigationItem.title = "Movie Details"
    view.backgroundColor = UIColor.systemBackground
  }
  
  private func setupObservers() {
    handleErrorIfAny(model.$error, cancellables: &cancellables)
    handleLoading(model.$isLoading, cancellables: &cancellables)
    model.$movie
      .receive(on: DispatchQueue.main)
      .sink { [weak self] movie in
        guard let self, let movie else { return }
        let presenter = MovieDetailsPresenter(movie: movie)
        presenter.configure(with: self.view as! MovieDetailsView)
      }.store(in: &cancellables)
  }
  
}

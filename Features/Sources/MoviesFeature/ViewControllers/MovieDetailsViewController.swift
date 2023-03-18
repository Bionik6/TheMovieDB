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
    handleLoading(model.$isLoading, cancellables: &cancellables)
    handleErrorIfAny(model.$error, cancellables: &cancellables)
    model.$movie
      .receive(on: DispatchQueue.main)
      .sink { [weak self] movieDetails in
        guard let self, let movieDetails else { return }
        let presenter = MovieDetailsPresenter(movieDetails: movieDetails)
        presenter.configure(with: self.view as! MovieDetailsView)
      }.store(in: &cancellables)
  }
  
}

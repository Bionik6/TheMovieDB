import UIKit
import Domain
import Combine
import DesignSystem


final class MovieDetailsPresenter {
  private var cancellable: AnyCancellable?
  
  let movieDetails: MovieDetails
  
  init(movieDetails: MovieDetails) {
    self.movieDetails = movieDetails
  }
  
  func configure(with view: MovieDetailsView) {
    cancellable = loadImage(for: view)
      .sink { [unowned self]
        image in self.showImage(image: image, for: view)
      }
    view.titleLabel.text = movieDetails.title
    view.yearLabel.text = movieDetails.releaseDate.formatted(date: .abbreviated, time: .omitted)
    view.descriptionLabel.text = movieDetails.overview
  }
  
  private func showImage(image: UIImage?, for view: MovieDetailsView) {
    view.imageView.image = image
  }
  
  private func loadImage(for view: MovieDetailsView) -> AnyPublisher<UIImage?, Never> {
    return Just(view.imageView)
      .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
        guard let imageURL = self.movieDetails.imageURL else { return Just(nil).eraseToAnyPublisher() }
        return ImageLoader.shared.loadImage(from: imageURL)
      })
      .eraseToAnyPublisher()
  }
  
}

import UIKit
import Domain
import Combine
import DesignSystem


final class MoviePresenter {
  private var cancellable: AnyCancellable?
  
  let movie: Movie
  
  init(movie: Movie) {
    self.movie = movie
  }
  
  func configure(with cell: MovieCollectionViewCell) {
    cancellable = loadImage(for: cell)
      .sink { [unowned self]
        image in self.showImage(image: image, for: cell)
      }
    cell.titleLabel.text = movie.title
    cell.yearLabel.text = movie.releaseDate.formatted(date: .abbreviated, time: .omitted)
  }
  
  private func showImage(image: UIImage?, for cell: MovieCollectionViewCell) {
    cell.imageView.image = image
    
  }
  
  private func loadImage(for cell: MovieCollectionViewCell) -> AnyPublisher<UIImage?, Never> {
    return Just(cell.imageView)
      .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
        guard let imageURL = self.movie.imageURL else { return Just(nil).eraseToAnyPublisher() }
        return ImageLoader.shared.loadImage(from: imageURL)
      })
      .eraseToAnyPublisher()
  }
  
}

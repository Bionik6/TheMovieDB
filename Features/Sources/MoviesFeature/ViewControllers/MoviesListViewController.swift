import UIKit
import Domain
import Combine
import DesignSystem


public enum Section {
  case main
}

public protocol MoviesListViewControllerDelegate: AnyObject {
  func didSelect(movie: Movie)
}

public class MoviesListViewController: NiblessViewController {
  private var cancellables = Set<AnyCancellable>()
  private let model: MoviesListViewModel
  
  private var collectionView: UICollectionView! = nil
  public weak var delegate: MoviesListViewControllerDelegate?
  private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>! = nil
  private var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Movie>! = nil
  
  public init(model: MoviesListViewModel) {
    self.model = model
    super.init()
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    configureHierarchy()
    configureDataSource()
    setupObservers()
    Task { await model.fetchMovies() }
  }
  
  private func setupView() {
    navigationItem.title = "Movies"
  }
  
  private func setupObservers() {
    handleErrorIfAny(model.$error, cancellables: &cancellables)
    handleLoading(model.$isLoading, cancellables: &cancellables)
    model.$movies
      .receive(on: DispatchQueue.main)
      .sink { [weak self] movies in
        guard let self else { return }
        self.currentSnapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        self.currentSnapshot.appendSections([.main])
        self.currentSnapshot.appendItems(movies, toSection: .main)
        self.dataSource.apply(self.currentSnapshot, animatingDifferences: true)
      }.store(in: &cancellables)
  }
}


extension MoviesListViewController {
  private func createLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(120)
    )
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
  
  private func configureHierarchy() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground
    collectionView.delegate = self
    view.addSubview(collectionView)
  }
  
  private func configureDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<MovieCollectionViewCell, Movie> { (cell, indexPath, movie) in
      let presenter = MoviePresenter(movie: movie)
      presenter.configure(with: cell)
    }
    
    dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
      return collectionView.dequeueConfiguredReusableCell(
        using: cellRegistration,
        for: indexPath,
        item: movie
      )
    })
  }
  
}


extension MoviesListViewController: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.didSelect(movie: model.movies[indexPath.item])
  }
  
  public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if shouldFetchNextPage(indexPath) { model.fetchMoviesAtNextPage() }
  }
  
  private func shouldFetchNextPage(_ indexPath: IndexPath) -> Bool {
    indexPath.item == model.movies.count - 2
  }
}

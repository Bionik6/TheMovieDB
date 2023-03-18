import UIKit
import Domain
import Combine
import DesignSystem

enum Section {
  case main
}

class MoviesListViewController: NiblessViewController {
  var cancellables = Set<AnyCancellable>()
  private var model: MoviesListViewModel
  
  private var collectionView: UICollectionView! = nil
  private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>! = nil
  private var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Movie>! = nil
  
  init(model: MoviesListViewModel) {
    self.model = model
    super.init()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Movies"
    configureHierarchy()
    configureDataSource()
    setupObservers()
    Task { await model.fetchMovies() }
  }
  
  func setupObservers() {
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
  func createLayout() -> UICollectionViewLayout {
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
    // section.interGroupSpacing = 80
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
  
  func configureHierarchy() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground
    collectionView.delegate = self
    view.addSubview(collectionView)
  }
  
  func configureDataSource() {
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
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // collectionView.deselectItem(at: indexPath, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if isLoadingLastIndexPath(indexPath) { model.fetchMoviesAtNextPage() }
  }
  
  private func isLoadingLastIndexPath(_ indexPath: IndexPath) -> Bool {
    return indexPath.item == model.movies.count
  }
}

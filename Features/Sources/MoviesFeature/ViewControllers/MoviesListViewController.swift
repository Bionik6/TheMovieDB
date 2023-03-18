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
  var cancellables = Set<AnyCancellable>()
  private var model: MoviesListViewModel
  
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
    model.$movies
      .receive(on: DispatchQueue.main)
      .sink { [weak self] movies in
        guard let self else { return }
        self.currentSnapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        self.currentSnapshot.appendSections([.main])
        self.currentSnapshot.appendItems(movies, toSection: .main)
        self.dataSource.apply(self.currentSnapshot, animatingDifferences: true)
      }.store(in: &cancellables)
    
    model.$isLoading
      .receive(on: DispatchQueue.main)
      .sink { [weak self] isLoading in
        guard let self else { return }
        if isLoading { self.showLoadingIndicator() }
        if !isLoading { self.hideLoadingIndicator() }
      }.store(in: &cancellables)
    
    model.$error
      .sink { [weak self] error in
        guard let error, let self else { return }
        self.show(error: error)
      }.store(in: &cancellables)
  }
  
  private func showLoadingIndicator() {
    MovieDBActivityIndicator.showAdded(
      to: view,
      title: "Please wait",
      message: "Please wait while we retrieve the list of breeds."
    )
  }
  
  private func hideLoadingIndicator() {
    MovieDBActivityIndicator.hide(for: view)
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
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.didSelect(movie: model.movies[indexPath.item])
  }
  
  public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if shouldFetchNextPage(indexPath) { model.fetchMoviesAtNextPage() }
  }
  
  private func shouldFetchNextPage(_ indexPath: IndexPath) -> Bool {
    return indexPath.item == model.movies.count - 2
  }
}

import Domain
import Combine
import Foundation


public final class MoviesListViewModel: ObservableObject {
  private let useCase: GetMoviesUseCase
  
  private var currentPage: Int = 1 {
    didSet { Task { await fetchMovies() } }
  }
  
  @Published var error: LocalizedError?
  @Published var movies: [Movie] = []
  @Published var isLoading: Bool = false
  
  public init(useCase: GetMoviesUseCase) {
    self.useCase = useCase
  }
  
  @MainActor
  func fetchMovies() async {
    defer { isLoading = false }
    do {
      isLoading = true
      let movies = try await useCase.execute(page: currentPage)
      self.movies.append(contentsOf: movies)
    } catch {
      self.error = error as? LocalizedError
    }
  }
  
  func fetchMoviesAtNextPage() {
    currentPage += 1
  }
}

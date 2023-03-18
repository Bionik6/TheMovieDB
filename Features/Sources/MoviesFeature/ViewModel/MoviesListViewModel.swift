import Domain
import Combine
import Foundation


final class MoviesListViewModel: ObservableObject {
  private let useCase: GetMoviesUseCase
  
  var currentPage: Int = 1 {
    didSet { Task { await fetchMovies() } }
  }
  
  @Published var error: LocalizedError?
  @Published var movies: [Movie] = []
  @Published var isLoading: Bool = false
  
  init(useCase: GetMoviesUseCase) {
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

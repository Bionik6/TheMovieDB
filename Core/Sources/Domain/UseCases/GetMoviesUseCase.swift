import Foundation

public struct GetMoviesUseCase {
  private let repository: MovieRepository
  
  public init(repository: MovieRepository) {
    self.repository = repository
  }
  
  public func execute(page: Int) async throws -> [Movie] {
    return try await repository.getMovies(page: page)
  }
  
}

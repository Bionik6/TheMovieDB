import Foundation

public struct GetMovieDetailsUseCase {
  private let movie: Movie
  private let repository: MovieRepository
  
  public init(movie: Movie, repository: MovieRepository) {
    self.movie = movie
    self.repository = repository
  }
  
  public func execute() async throws -> Movie {
    return try await repository.getMovieDetails(for: movie)
  }
}

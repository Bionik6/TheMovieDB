import Foundation


public protocol MovieRepository {
  func getMovies(page: Int) async throws -> [Movie]
  func getMovieDetails(for movie: Movie) async throws -> MovieDetails
}

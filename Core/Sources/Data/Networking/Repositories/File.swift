import Domain
import Foundation


public struct DefaultMovieRepository: MovieRepository {
  
  public init() { }
  
  public func getMovies(page: Int) async throws -> [Domain.Movie] {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
      throw DomainError.APIKeyNotSet
    }
    let request = Request(path: "discover/movie", params: .url(["api_key": apiKey, "page": page]))
    let result: RemoteMoviesDiscovery = try await NetNet.execute(request: request)
    return result.toDomain
  }
  
  public func getMovieDetails(for movie: Domain.Movie) async throws -> Domain.MovieDetails {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
      throw DomainError.APIKeyNotSet
    }
    let request = Request(path: "movie/\(movie.id)", params: .url(["api_key": apiKey]))
    let result: RemoteMovieDetails = try await NetNet.execute(request: request)
    return result.toDomain
  }
  
}

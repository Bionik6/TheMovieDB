import Data
import Domain
import Foundation



struct MockHappyPathMovieRepository: MovieRepository {
  func getMovies(page: Int) async throws -> [Domain.Movie] {
    return FixtureLoader.loadMoviesList().toDomain
  }
  
  func getMovieDetails(for movie: Domain.Movie) async throws -> Domain.Movie {
    return FixtureLoader.loadMovieDetails().toDomain
  }
}


struct MockErrorMovieRepository: MovieRepository {
  func getMovies(page: Int) async throws -> [Domain.Movie] {
    throw NetworkError.noInternetConnectivity.toDomain
  }
  
  func getMovieDetails(for movie: Domain.Movie) async throws -> Domain.Movie {
    throw NetworkError.noInternetConnectivity.toDomain
  }
}


struct MockEmptyMovieRepository: MovieRepository {
  func getMovies(page: Int) async throws -> [Domain.Movie] {
    return []
  }
  
  func getMovieDetails(for movie: Domain.Movie) async throws -> Domain.Movie {
    return FixtureLoader.loadMovieDetails().toDomain
  }
}


extension Movie {
  static let sample = Movie(id: 1, title: "", overview: "", releaseDate: .now, posterPath: "")
}

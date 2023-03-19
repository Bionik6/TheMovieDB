import Data
import Domain
import Foundation



struct MockHappyPathMovieRepository: MovieRepository {
  func getMovies(page: Int) async throws -> [Domain.Movie] {
    return FixtureLoader.loadMoviesList().toDomain
  }
  
  func getMovieDetails(for movie: Domain.Movie) async throws -> Domain.MovieDetails {
    return FixtureLoader.loadMovieDetails().toDomain
  }
}


struct MockErrorMovieRepository: MovieRepository {
  func getMovies(page: Int) async throws -> [Domain.Movie] {
    throw NetworkError.noInternetConnectivity.toDomain
  }
  
  func getMovieDetails(for movie: Domain.Movie) async throws -> Domain.MovieDetails {
    throw NetworkError.noInternetConnectivity.toDomain
  }
}


struct MockEmptyMovieRepository: MovieRepository {
  func getMovies(page: Int) async throws -> [Domain.Movie] {
    return []
  }
  
  func getMovieDetails(for movie: Domain.Movie) async throws -> Domain.MovieDetails {
    return FixtureLoader.loadMovieDetails().toDomain
  }
}


extension Movie {
  static let sample = Movie(id: 1, adult: true, video: true, title: "", voteCount: 0, genreIds: [], overview: "", releaseDate: .now, popularity: 0, posterPath: "", voteAverage: 0, backdropPath: "", originalTitle: "", originalLanguage: "")
}

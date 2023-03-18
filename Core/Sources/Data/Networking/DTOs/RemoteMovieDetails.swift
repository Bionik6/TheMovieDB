import Domain
import Foundation


public struct RemoteMovieDetails: Decodable {
  public let adult: Bool
  public let backdropPath: String
  public let budget: Int
  public let genres: [RemoteGenre]
  public let homepage: URL
  public let id: Int
  public let imdbId: String
  public let originalLanguage: String
  public let originalTitle: String
  public let overview: String
  public let popularity: Double
  public let posterPath: String
  public let releaseDate: Date
  public let revenue: Int
  public let runtime: Int
  public let status: String
  public let tagline: String
  public let title: String
  public let video: Bool
  public let voteAverage: Double
  public let voteCount: Int
  
  
  public var toDomain: MovieDetails {
    MovieDetails(
      id: id,
      adult: adult,
      budget: budget,
      video: video,
      revenue: revenue,
      runtime: runtime,
      homepage: homepage,
      title: title,
      imdbId: imdbId,
      status: status,
      voteCount: voteCount,
      genres: genres.map(\.toDomain),
      tagline: tagline,
      overview: overview,
      releaseDate: releaseDate,
      popularity: popularity,
      posterPath: posterPath,
      voteAverage: voteAverage,
      backdropPath: backdropPath,
      originalTitle: originalTitle,
      originalLanguage: originalLanguage
    )
  }
}



public struct RemoteGenre: Decodable {
  public let id: Int
  public let name: String
  
  public var toDomain: Genre {
    Genre(id: id, name: name)
  }
}

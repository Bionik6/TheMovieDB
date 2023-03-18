import Domain
import Foundation


public struct RemoteMovieDetails: Decodable {
  public let adult: Bool
  public let backdropPath: String
  public let budget: Int
  public let genres: [Genre]
  public let homepage: URL
  public let id: Int
  public let imdbId: String
  public let originalLanguage: String
  public let originalTitle: String
  public let overview: String
  public let popularity: Double
  public let posterPath: String
  public let productionCountries: [ProductionCountry]
  public let releaseDate: Date
  public let revenue: Int
  public let runtime: Int
  public let spokenLanguages: [SpokenLanguage]
  public let status: String
  public let tagline: String
  public let title: String
  public let video: Bool
  public let voteAverage: Double
  public let voteCount: Int
}


public struct ProductionCountry: Decodable {
  enum CodingKeys: String, CodingKey, CaseIterable {
    case iso31661 = "iso_3166_1"
    case name
  }
  
  public let iso31661: String
  public let name: String
}


public struct SpokenLanguage: Decodable {
  enum CodingKeys: String, CodingKey, CaseIterable {
    case englishName = "english_name"
    case iso6391 = "iso_639_1"
    case name
  }
  
  public let englishName: String
  public let iso6391: String
  public let name: String
}


public struct Genre: Decodable {
  public let id: Int
  public let name: String
}

import Domain
import Foundation


public struct RemoteMoviesDiscovery: Decodable {
  public let page: Int
  public let results: [RemoteMovie]
  public let totalPages: Int
  public let totalResults: Int
}

public struct RemoteMovie: Decodable {
  public let adult: Bool
  public let backdropPath: String
  public let genreIds: [Int]
  public let id: Int
  public let originalLanguage: String
  public let originalTitle: String
  public let overview: String
  public let popularity: Double
  public let posterPath: String
  public let releaseDate: Date
  public let title: String
  public let video: Bool
  public let voteAverage: Double
  public let voteCount: Int
}

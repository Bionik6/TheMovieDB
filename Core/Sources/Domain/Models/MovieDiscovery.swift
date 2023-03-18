import Foundation


public struct MoviesDiscovery {
  public var page: Int
  public var totalPages: Int
  public var totalResults: Int
  public var results: [Movie]
}


public struct Movie: Identifiable {
  public let id: Int
  public let adult: Bool
  public let video: Bool
  public let title: String
  public let voteCount: Int
  public let genreIds: [Int]
  public let overview: String
  public let releaseDate: Date
  public let popularity: Double
  public let posterPath: String
  public let voteAverage: Double
  public let backdropPath: String
  public let originalTitle: String
  public let originalLanguage: String
}

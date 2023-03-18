import Foundation


public struct MoviesDiscovery {
  public var page: Int
  public var totalPages: Int
  public var totalResults: Int
  public var results: [Movie]
  
  public init(
    page: Int,
    totalPages: Int,
    totalResults: Int,
    results: [Movie]
  ) {
    self.page = page
    self.totalPages = totalPages
    self.totalResults = totalResults
    self.results = results
  }
}


public struct Movie: Identifiable, Hashable {
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
  
  public var imageURL: URL? {
    let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
    guard let url = URL(string: urlString) else { return nil }
    return url
  }
  
  public init(
    id: Int,
    adult: Bool,
    video: Bool,
    title: String,
    voteCount: Int,
    genreIds: [Int],
    overview: String,
    releaseDate: Date,
    popularity: Double,
    posterPath: String,
    voteAverage: Double,
    backdropPath: String,
    originalTitle: String,
    originalLanguage: String
  ) {
    self.id = id
    self.adult = adult
    self.video = video
    self.title = title
    self.voteCount = voteCount
    self.genreIds = genreIds
    self.overview = overview
    self.releaseDate = releaseDate
    self.popularity = popularity
    self.posterPath = posterPath
    self.voteAverage = voteAverage
    self.backdropPath = backdropPath
    self.originalTitle = originalTitle
    self.originalLanguage = originalLanguage
  }
}

import Foundation


public struct Movie: Identifiable, Hashable {
  public let id: Int
  public let title: String
  public let overview: String
  public let releaseDate: Date
  public let posterPath: String
  
  public var imageURL: URL? {
    let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
    guard let url = URL(string: urlString) else { return nil }
    return url
  }
  
  public init(
    id: Int,
    title: String,
    overview: String,
    releaseDate: Date,
    posterPath: String
  ) {
    self.id = id
    self.title = title
    self.overview = overview
    self.releaseDate = releaseDate
    self.posterPath = posterPath
  }
}

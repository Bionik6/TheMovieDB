import Domain
import Foundation


public struct RemoteMovie: Decodable {
  public let id: Int
  public let title: String
  public let overview: String
  public let releaseDate: Date
  public let posterPath: String
  
  public var toDomain: Movie {
    Movie(
      id: id,
      title: title,
      overview: overview,
      releaseDate: releaseDate,
      posterPath: posterPath
    )
  }
}

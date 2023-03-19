import Domain
import Foundation


public struct RemoteMoviesDiscovery: Decodable {
  public let page: Int
  public let results: [RemoteMovie]
  public let totalPages: Int
  public let totalResults: Int
  
  public var toDomain: [Movie] {
    results.map { $0.toDomain }
  }
}

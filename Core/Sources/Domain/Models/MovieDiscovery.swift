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

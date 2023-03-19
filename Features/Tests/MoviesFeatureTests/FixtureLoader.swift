import Data
import Foundation


public struct FixtureLoader {
  private static func loadFixture<T: Decodable>(
    filename name: String,
    file: StaticString = #file,
    line: UInt = #line
  ) -> T {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appending(path: "Fixtures/\(name)")
    let data = try? Data(contentsOf: url)
    guard let data, let object: T = try? JSONDecoder.live.decode(T.self, from: data)
    else {
      fatalError("could not load resource: \(name)", file: file, line: line)
    }
    return object
  }
  
  public static func loadMoviesList() -> RemoteMoviesDiscovery {
    loadFixture(filename: "movies_list.json")
  }
  
  public static func loadMovieDetails() -> RemoteMovieDetails {
    loadFixture(filename: "movie_details.json")
  }
}

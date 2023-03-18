import Domain
import Foundation


public class APIClient {
  private var session: URLSession
  private var baseURLString: NSString
  
  public init(
    baseURLString: NSString,
    session: URLSession = .shared
  ) {
    self.session = session
    self.baseURLString = baseURLString
  }
  
  public func execute<D: Decodable>(request: Request) async throws -> D {
    do {
      let sessionRequest = prepareURLRequest(for: request)
      let (data, response) = try await session.data(for: sessionRequest)
      
      if let HTTPResponse = response as? HTTPURLResponse {
        if 500...599 ~= HTTPResponse.statusCode { throw NetworkError.serverError }
        if HTTPResponse.statusCode == 400 { throw NetworkError.badRequest }
        if HTTPResponse.statusCode == 401 { throw NetworkError.unauthorized }
        if HTTPResponse.statusCode == 403 { throw NetworkError.forbidden }
      }
      
      guard let object = try? JSONDecoder.live.decode(D.self, from: data) else { throw NetworkError.unprocessableData }
      return object
      
    } catch {
      if let urlError = error as? URLError {
        let urlErrors: [URLError.Code] = [.notConnectedToInternet, .timedOut]
        if urlErrors.contains(urlError.code) { throw NetworkError.noInternetConnectivity }
      }
      throw error
    }
  }
  
  private func prepareURLRequest(for request: Request, token: String? = nil) -> URLRequest {
    let fullURLString = baseURLString.appendingPathComponent(request.path)
    guard let url = URL(string: fullURLString) else { fatalError("The URL is not valid") }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    if let params = request.params {
      switch params {
        case .body(let encodedBody):
          urlRequest.httpBody = try? JSONEncoder().encode(encodedBody)
        case .url(let urlParams):
          if var components = URLComponents(string: fullURLString) {
            components.queryItems = urlParams.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
            urlRequest.url = components.url
          }
      }
    }
    urlRequest.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Accept")
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    if let token { urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") }
    return urlRequest
  }
  
}


public let NetNet = APIClient(baseURLString: "https://api.themoviedb.org/3/")

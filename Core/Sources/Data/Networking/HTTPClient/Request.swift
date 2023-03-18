import Foundation

public struct Request {
  var path: String
  var method: HTTPMethod
  var params: RequestParams?
  
  public init(
    path: String,
    method: HTTPMethod = .get,
    params: RequestParams? = nil
  ) {
    self.path = path
    self.method = method
    self.params = params
  }
}

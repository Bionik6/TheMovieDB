import Domain
import Foundation

public enum NetworkError: LocalizedError, Equatable {
  case serverError // 500
  case unauthorized // 401
  case forbidden // 403
  case badRequest // 400
  case noInternetConnectivity
  case unknown // default
  case unprocessableData
  
  
  public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    lhs.failureReason == rhs.failureReason
  }
  
  public var failureReason: String? {
    switch self {
      case .serverError:
        return "We encounter a server issue. Please try again."
      case .unauthorized:
        return "You're not authorized to execute this request."
      case .forbidden:
        return "You're not authorized to execute this request. Please verify the token validity."
      case .badRequest:
        return "Bad Request, please verify your input."
      case .noInternetConnectivity:
        return "It seems you're not online. Please verify your internet connectivity."
      case .unknown:
        return "Something bad happens, please try again."
      case .unprocessableData:
        return "Seems like the data couldn't be processed correctly."
    }
  }
  
  public var toDomain: DomainError {
    switch self {
      case .noInternetConnectivity:
        return .noInternetConnectivity
      default:
        return .serverError(self)
    }
  }
}

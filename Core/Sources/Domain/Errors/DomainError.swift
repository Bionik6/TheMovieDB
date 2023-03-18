/**
 *  SuperBreed
 *  DomainError.swift
 *  Copyright (c) Ibrahima Ciss 2022
 */

import Foundation

public enum DomainError: LocalizedError {
  case unknown
  case noInternetConnectivity
  case serverError(LocalizedError)
  case storageError(LocalizedError)
  
  public var errorDescription: String? {
    switch self {
      case .noInternetConnectivity:
        return "No internet connectivity"
      default:
        return "Something wrong happens"
    }
  }
  
  public var failureReason: String? {
    switch self {
      case .noInternetConnectivity:
        return "It seems like you are not connected to internet. Please verify your internet connection and try again. \(showErrorType())"
      case .storageError(let error), .serverError(let error):
        return error.failureReason
      case .unknown:
        return "Something bad happens and I don't know why. \(showErrorType())"
    }
  }
}


extension LocalizedError {
  public func showErrorType() -> String {
#if(DEBUG)
    return "\n[ErrorType = \(self)]"
#else
    return ""
#endif
  }
}

import Domain
import Combine
import Foundation


public final class MovieDetailsViewModel: ObservableObject {
  private let useCase: GetMovieDetailsUseCase
  
  @Published var movie: MovieDetails?
  @Published var error: LocalizedError?
  @Published var isLoading: Bool = false
  
  public init(useCase: GetMovieDetailsUseCase) {
    self.useCase = useCase
  }
  
  @MainActor
  func fetchMovieDetails() async {
    defer { isLoading = false }
    do {
      isLoading = true
      self.movie = try await useCase.execute()
    } catch {
      self.error = error as? LocalizedError
    }
  }
  
}

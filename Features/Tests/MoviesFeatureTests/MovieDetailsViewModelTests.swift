import Domain
import XCTest
@testable import MoviesFeature


final class MovieDetailsViewModelTests: XCTestCase {
  
  func test_sut_error_is_not_nil_when_repository_sends_error_from_fetch_movie_details() async {
    let repo = MockErrorMovieRepository()
    let useCase = GetMovieDetailsUseCase(movie: .sample, repository: repo)
    let sut = MovieDetailsViewModel(useCase: useCase)
    
    XCTAssertNil(sut.error)
    
    await sut.fetchMovieDetails()
    
    XCTAssertNotNil(sut.error)
    XCTAssertNil(sut.movie)
    let domainError = try? XCTUnwrap(sut.error as? DomainError)
    XCTAssertEqual(domainError?.failureReason, DomainError.noInternetConnectivity.failureReason)
  }
  
  func test_sut_movies_details_is_not_nil_when_repository_sends_successful_response_from_fetch_movie_details() async {
    let repo = MockHappyPathMovieRepository()
    let useCase = GetMovieDetailsUseCase(movie: .sample, repository: repo)
    let sut = MovieDetailsViewModel(useCase: useCase)
    
    XCTAssertNil(sut.error)
    XCTAssertNil(sut.movie)
    
    await sut.fetchMovieDetails()
    
    XCTAssertNil(sut.error)
    XCTAssertNotNil(sut.movie)
    XCTAssertEqual(sut.movie?.id, FixtureLoader.loadMovieDetails().toDomain.id)
    XCTAssertEqual(sut.movie?.title, FixtureLoader.loadMovieDetails().toDomain.title)
    XCTAssertEqual(sut.movie?.imageURL, FixtureLoader.loadMovieDetails().toDomain.imageURL)
  }

}

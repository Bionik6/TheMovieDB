import Domain
import XCTest
@testable import MoviesFeature


final class MoviesListViewModelTests: XCTestCase {

  func test_sut_error_is_not_nil_when_repository_sends_error_from_fetch_movies_list() async {
    let repo = MockErrorMovieRepository()
    let useCase = GetMoviesUseCase(repository: repo)
    let sut = MoviesListViewModel(useCase: useCase)
    
    XCTAssertNil(sut.error)
    
    await sut.fetchMovies()
    
    XCTAssertNotNil(sut.error)
    XCTAssertTrue(sut.movies.isEmpty)
    let domainError = try? XCTUnwrap(sut.error as? DomainError)
    XCTAssertEqual(domainError?.failureReason, DomainError.noInternetConnectivity.failureReason)
  }
  
  func test_sut_movies_is_not_empty_when_repository_sends_successful_response_from_fetch_movies_list() async {
    let repo = MockHappyPathMovieRepository()
    let useCase = GetMoviesUseCase(repository: repo)
    let sut = MoviesListViewModel(useCase: useCase)
    
    XCTAssertNil(sut.error)
    XCTAssertTrue(sut.movies.isEmpty)
    
    await sut.fetchMovies()
    
    XCTAssertNil(sut.error)
    XCTAssertFalse(sut.movies.isEmpty)
    XCTAssertEqual(sut.movies.count, FixtureLoader.loadMoviesList().toDomain.count)
  }
  
  func test_mutating_sut_currentPage_fetches_movies_list() async throws {
    let repo = MockHappyPathMovieRepository()
    let useCase = GetMoviesUseCase(repository: repo)
    let sut = MoviesListViewModel(useCase: useCase)
    
    await sut.fetchMovies()
    
    XCTAssertNil(sut.error)
    XCTAssertFalse(sut.movies.isEmpty)
    XCTAssertEqual(sut.movies.count, FixtureLoader.loadMoviesList().toDomain.count)
    
    sut.fetchMoviesAtNextPage()
    
    let duration = Duration(secondsComponent: 0, attosecondsComponent: Int64(10_000_000_000_000_000))
    
    try await Task.sleep(for: duration)
    
    XCTAssertEqual(sut.movies.count, 40)
    
    sut.fetchMoviesAtNextPage()
    
    try await Task.sleep(for: duration)
    
    XCTAssertEqual(sut.movies.count, 60)
  }
  
}

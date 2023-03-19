import Data
import XCTest
import Domain
import MoviesFeature


final class MovieRepositoryTests: XCTestCase {
  
  func test_fetching_movies_list_with_network_error_sends_an_error() async {
    let sut = MockErrorMovieRepository()
    do {
      _ = try await sut.getMovies(page: 1)
      XCTFail("Shouldn't be executed since there is a network error")
    } catch {
      XCTAssertNotNil(error)
      let domainError = try? XCTUnwrap(error as? DomainError)
      XCTAssertEqual(domainError?.failureReason, DomainError.noInternetConnectivity.failureReason)
    }
  }
  
  func test_fetching_movies_list_with_with_empty_network_response_sends_empty_list_of_movies() async {
    let sut = MockEmptyMovieRepository()
    do {
      let result = try await sut.getMovies(page: 1)
      XCTAssertEqual(result.count, 0)
    } catch {
      XCTFail("No error should be raised with a successful response")
    }
  }

  func test_fetching_movies_list_with_with_successfull_network_response_sends_list_of_movies() async {
    let sut = MockHappyPathMovieRepository()
    do {
      let result = try await sut.getMovies(page: 1)
      XCTAssertEqual(result.count, FixtureLoader.loadMoviesList().toDomain.count)
    } catch {
      XCTFail("No error should be raised with a successful response")
    }
  }

  func test_fetching_movie_details_on_network_error_sends_an_error() async {
    let sut = MockErrorMovieRepository()
    do {
      _ = try await sut.getMovieDetails(for: Movie.sample)
      XCTFail("Shouldn't be executed since there is a network error")
    } catch {
      XCTAssertNotNil(error)
      let domainError = try? XCTUnwrap(error as? DomainError)
      XCTAssertEqual(domainError?.failureReason, DomainError.noInternetConnectivity.failureReason)
    }
  }

  func test_fetching_movie_details_with_with_successfull_network_response_sends_movie_details() async {
    let sut = MockHappyPathMovieRepository()
    do {
      let result = try await sut.getMovieDetails(for: .sample)
      XCTAssertEqual(result.id, FixtureLoader.loadMovieDetails().toDomain.id)
      XCTAssertEqual(result.title, FixtureLoader.loadMovieDetails().toDomain.title)
    } catch {
      XCTFail("No error should be raised with a successful response")
    }
  }
  
}

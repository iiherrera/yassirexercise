//
//  MovieDetailViewModelTests.swift
//  YassirExerciseTests
//
//  Created by Iván Herrera on 12/27/23.
//

import XCTest
import Combine
@testable import YassirExercise

class MovieDetailViewModelTests: XCTestCase {

    var sut: MovieDetailViewModel!
    var mockMoviesAPIService: MockMoviesAPIService!
    var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        sut = MovieDetailViewModel(movieDetailID: 1)
        // We inject a mock of the MoviesAPIService in order to control that input
        mockMoviesAPIService = MockMoviesAPIService()
        sut.moviesAPIService = mockMoviesAPIService
    }

    override func tearDownWithError() throws {
        sut = nil
        mockMoviesAPIService = nil
    }
    
    // Test the successful path of fetchMovieDetail()
    func testFetchMovieDetailWithSuccess() {
        
        let movieDetailExpectation = XCTestExpectation(description: "Movie detail must be published")
        
        // We set up the mock to return success with a movie detail
        mockMoviesAPIService.returnMovieDetailResult = .success(MockMoviesAPIService.generateMovieDetail())
        
        sut.$movieDetail.dropFirst().sink { movieDetail in
            // We fulfill the expectation if movieDetail is published as it is the successful output
            // of fetchMovieDetail()
            if movieDetail != nil {
                movieDetailExpectation.fulfill()
            }
        }.store(in: &subscriptions)
        
        sut.$alert.dropFirst().sink { alert in
            // With a succesful API response, an alert shouldn't be displayed
            XCTFail("Alert shouldn't be displayed")
        }.store(in: &subscriptions)
        
        sut.fetchMovieDetail()
        self.wait(for: [movieDetailExpectation], timeout: 0.1)
    }
    
    // Test the unsuccessful path of fetchMovieDetail()
    func testFetchMovieDetailWithError() {
        
        let alertExpectation = XCTestExpectation(description: "Alert must be displayed")
        let emptyMovieDetailExpectation = XCTestExpectation(description: "Movie detail must be empty")
        
        // We set up the mock to return failure with an error
        mockMoviesAPIService.returnMovieDetailResult = .failure(.unknownError)
        
        sut.$movieDetail.dropFirst().sink { movieDetail in
            // An empty movie detail should be published if there is an error in the API
            if movieDetail == MovieDetail.empty {
                emptyMovieDetailExpectation.fulfill()
            }
        }.store(in: &subscriptions)
        
        sut.$alert.dropFirst().sink { alert in
            // An alert should be displayed if there is an error in the API
            alertExpectation.fulfill()
        }.store(in: &subscriptions)
        
        sut.fetchMovieDetail()
        self.wait(for: [alertExpectation, emptyMovieDetailExpectation], timeout: 0.1)
    }


}

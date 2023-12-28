//
//  MoviesViewModelTests.swift
//  YassirExerciseTests
//
//  Created by Iván Herrera on 12/27/23.
//

import XCTest
import Combine
@testable import YassirExercise

class MoviesViewModelTests: XCTestCase {

    var sut: MoviesViewModel!
    var mockMoviesAPIService: MockMoviesAPIService!
    var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        sut = MoviesViewModel()
        // We inject a mock of the MoviesAPIService in order to control that input
        mockMoviesAPIService = MockMoviesAPIService()
        sut.moviesAPIService = mockMoviesAPIService
    }

    override func tearDownWithError() throws {
        sut = nil
        mockMoviesAPIService = nil
    }
    
    // Test the successful path of fetchMovies()
    func testFetchMoviesWithSuccess() {
        
        let moviesExpectation = XCTestExpectation(description: "Movies must be published")
        
        // We set up the mock to return success with an array of movies
        mockMoviesAPIService.returnMoviesResult = .success(MockMoviesAPIService.generateMovies())
        
        sut.$movies.dropFirst().sink { movies in
            // We fulfill the expectation if movies is published as it is the successful output
            // of fetchMovies(), and if the array has a size of 2 (as constructed in the mock)
            if movies.count == 2 {
                moviesExpectation.fulfill()
            }
        }.store(in: &subscriptions)
        
        sut.$alert.dropFirst().sink { alert in
            // With a succesful API response, an alert shouldn't be displayed
            XCTFail("Alert shouldn't be displayed")
        }.store(in: &subscriptions)
        
        sut.fetchMovies()
        self.wait(for: [moviesExpectation], timeout: 0.1)
    }
    
    // Test the unsuccessful path of fetchMovies()
    func testFetchMoviesWithError() {
        
        let alertExpectation = XCTestExpectation(description: "Alert must be displayed")
        let emptyMoviesExpectation = XCTestExpectation(description: "Movies must be empty")
        
        // We set up the mock to return failure with an error
        mockMoviesAPIService.returnMoviesResult = .failure(.unknownError)
        
        sut.$movies.dropFirst().sink { movies in
            // An empty array of movies should be published if there is an error in the API
            if movies.isEmpty {
                emptyMoviesExpectation.fulfill()
            }
        }.store(in: &subscriptions)
        
        sut.$alert.dropFirst().sink { alert in
            // An alert should be displayed if there is an error in the API
            alertExpectation.fulfill()
        }.store(in: &subscriptions)
        
        sut.fetchMovies()
        self.wait(for: [alertExpectation, emptyMoviesExpectation], timeout: 0.1)
    }


}

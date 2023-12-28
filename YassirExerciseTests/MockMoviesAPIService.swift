//
//  MockMoviesAPIService.swift
//  YassirExerciseTests
//
//  Created by Iván Herrera on 12/27/23.
//

import Foundation
@testable import YassirExercise

class MockMoviesAPIService: MoviesAPIServiceProtocol {
    var returnMoviesResult: Result<[Movie], FetchError>!
    var returnMovieDetailResult: Result<MovieDetail, FetchError>!

    func fetchMovies(completion: @escaping (Result<[Movie], FetchError>) -> Void) {
        completion(returnMoviesResult)
    }
    func fetchMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, FetchError>) -> Void) {
        completion(returnMovieDetailResult)
    }

    static func generateMovies() -> [Movie] {
        let json = """
             {
               "page": 1,
               "results": [
                 {
                   "id": 1,
                   "poster_path": "/sadsadsa.jpg",
                   "release_date": "2023-11-15",
                   "title": "Test Movie 1"
                 },
                 {
                   "id": 2,
                   "poster_path": "/vdfvdvcds.jpg",
                   "release_date": "2023-12-20",
                   "title": "Test Movie 2"
                 }
               ]
            }
            """
        return try! JSONDecoder().decode(MoviesWrapper.self, from: json.data(using: .utf8)!).results
    }
    
    static func generateMovieDetail() -> MovieDetail {
        let json = """
            {
              "id": 1,
              "overview": "Some overview",
              "poster_path": "/sadsadsa.jpg",
              "release_date": "2023-11-15",
              "title": "Test Movie 1",
            }
            """
        return try! JSONDecoder().decode(MovieDetail.self, from: json.data(using: .utf8)!)
    }


}

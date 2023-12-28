//
//  MoviesAPIService.swift
//  YassirExercise
//
//  Created by Iván Herrera on 12/26/23.
//

import Foundation

protocol MoviesAPIServiceProtocol {
    func fetchMovies(completion: @escaping (Result<[Movie], FetchError>) -> Void)
    func fetchMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, FetchError>) -> Void)
}

class MoviesAPIService: APIService, MoviesAPIServiceProtocol {
    
    // This function fetches the list of trending movies. When it finish, a completion handler
    // is called with a Result type containing either a movies array or a Fetch Error
    func fetchMovies(completion: @escaping (Result<[Movie], FetchError>) -> Void) {
        let url = Constants.moviesURL + "&api_key=\(Constants.apiKey)"
        fetch(url: url, method: "GET", type: MoviesWrapper.self) { result in
            // We want to make sure to call this on the main thread to update the UI
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    completion(.success(result.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    // This function fetches the details of a movie based on its ID. When it finish, a completion
    // handler is called with a Result type containing either the movie detail or a Fetch Error
    func fetchMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, FetchError>) -> Void) {
        let url = Constants.movieDetailURL + String(id) + "?api_key=\(Constants.apiKey)"
        fetch(url: url, method: "GET", type: MovieDetail.self) { result in
            // We want to make sure to call this on the main thread to update the UI
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

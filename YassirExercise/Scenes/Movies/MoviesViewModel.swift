//
//  MoviesViewModel.swift
//  YassirExercise
//
//  Created by Iván Herrera on 12/26/23.
//

import Foundation

class MoviesViewModel: ObservableObject {
    var moviesAPIService: MoviesAPIServiceProtocol = MoviesAPIService()
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var alert: IdentifiableAlert?

    func fetchMovies() {
        // We show the loading view
        self.isLoading = true
        moviesAPIService.fetchMovies { [unowned self] result in
            // On response, we hide the loading view
            self.isLoading = false
            
            switch result {
            case .success(let movies):
                // If we get a successful response from the API, we publish the movies
                // array and the list is displayed in the view
                self.movies = movies
                
            case .failure(_):
                // If the API response is not successful, we publish an empty array
                // and display an alert which allows the user to re-try
                self.movies = []
                self.alert = IdentifiableAlert(alertText: "couldnt-download-movies", alertTitle: "error", buttonTitle: "ok", action: {
                    // When the user press "OK" we try to fetch again
                    fetchMovies()
                })
            }
        }
    }
}

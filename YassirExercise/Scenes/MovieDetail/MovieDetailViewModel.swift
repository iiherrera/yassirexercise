//
//  MovieDetailViewModel.swift
//  YassirExercise
//
//  Created by Iván Herrera on 12/26/23.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    var moviesAPIService: MoviesAPIServiceProtocol = MoviesAPIService()
    let movieDetailID: Int
    @Published var movieDetail: MovieDetail?
    @Published var isLoading = true
    @Published var alert: IdentifiableAlert?
    
    init(movieDetailID: Int) {
        self.movieDetailID = movieDetailID
    }

    func fetchMovieDetail() {
        // We show the loading view
        self.isLoading = true
        moviesAPIService.fetchMovieDetail(id: movieDetailID) { [weak self] result in
            guard let self = self else { return }
            
            // On response, we hide the loading view
            self.isLoading = false
            
            switch result {
            case .success(let movieDetail):
                // If we get a successful response from the API, we publish the MovieDetail
                // object and the movie details are displayed in the view
                self.movieDetail = movieDetail
                
            case .failure(_):
                // If the API response is not successful, we publish an empty MovieDetail
                // to show the poster placeholder and we display an alert
                self.movieDetail = MovieDetail.empty
                self.alert = IdentifiableAlert(alertText: "couldnt-download-movie-detail", alertTitle: "error", buttonTitle: "ok", action: {})
            }
        }
    }
}

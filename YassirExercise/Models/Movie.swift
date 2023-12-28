//
//  Movie.swift
//  YassirExercise
//
//  Created by Iván Herrera on 12/26/23.
//

import Foundation

struct Movie: Decodable, Identifiable, Equatable{
    let id: Int
    let title: String
    let release_date: String
    let poster_path: String
    
    // We usually only need to show the year
    var year: String {
        String(release_date.prefix(4))
    }
    
    // This returns the absolute URL (or nil if malformed) of the movie poster
    var imageURL: URL? {
        URL(string: Constants.moviePosterURL + poster_path)
    }
}

// We use this wrapper struct to decode the json provided by the API
struct MoviesWrapper: Decodable{
    let results: [Movie]
}

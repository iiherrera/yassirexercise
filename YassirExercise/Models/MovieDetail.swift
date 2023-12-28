//
//  MovieDetail.swift
//  YassirExercise
//
//  Created by Iván Herrera on 12/26/23.
//

import Foundation

struct MovieDetail: Decodable, Identifiable, Equatable{
    let id: Int
    let title: String
    let overview: String
    let release_date: String
    let poster_path: String
    
    // We usually only need to show the year
    var year: String {
        String(release_date.prefix(4))
    }
    
    // This returns the absolute URL (or nil if malformed) of the movie poster, if poster_path is not empty.
    // Otherwise it returns nil
    var imageURL: URL? {
        if !poster_path.isEmpty {
            return URL(string: Constants.movieDetailPosterURL + poster_path)
        } else {
            return nil
        }
    }
    
    // This is a constructor for an empty MovieDetail model
    static var empty: MovieDetail {
        MovieDetail(id: 0, title: "", overview: "", release_date: "", poster_path: "")
    }
}

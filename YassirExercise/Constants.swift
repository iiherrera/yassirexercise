//
//  Constants.swift
//  YassirExercise
//
//  Created by Iván Herrera on 12/26/23.
//

import Foundation

struct Constants {
    
    //MARK: API
    
    #error("Please add your API key below then delete this line")
    static let apiKey = ""
    
    static let moviesURL = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc"
    static let movieDetailURL = "https://api.themoviedb.org/3/movie/"
    static let moviePosterURL = "https://image.tmdb.org/t/p/w200/"
    static let movieDetailPosterURL = "https://image.tmdb.org/t/p/w400/"
    
    //MARK: Misc
    
    static let moviePlaceholderPoster = "film"
}

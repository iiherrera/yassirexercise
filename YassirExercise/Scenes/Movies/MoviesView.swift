//
//  MoviesView.swift
//  YassirExercise
//
//  Created by Iván Herrera on 12/26/23.
//

import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel = MoviesViewModel()
    var body: some View {
        NavigationView {
            Group {
                // We show the movie list if the viewmodel is not waiting for the API
                if !viewModel.isLoading {
                    List(viewModel.movies) { movie in
                        // If the user taps on a row, we display the movie detail
                        NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movieDetailID: movie.id))) {
                                HStack {
                                    AsyncImage(url: movie.imageURL) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100)
                                    } placeholder: {
                                        Image(systemName: Constants.moviePlaceholderPoster)
                                            .resizable()
                                            .frame(width: 100, height: 150)
                                            .scaledToFill()
                                            .foregroundColor(Color(UIColor.systemGray6))
                                    }
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(movie.title)
                                            .font(.system(size: 17, weight: .semibold))
                                        Text(movie.year)
                                            .font(.system(size: 14))
                                    }
                                }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    
                // We show the loading view otherwise
                } else {
                    LoadingView()
                }
            }
            .navigationBarTitle("trending-movies")
            
            // This is used to show an alert when viewmodel.alert gets published
            .alert(item: $viewModel.alert) { $0.builtAlert }
            
        // When the view appears, we ask the viewmodel to load the trending movie list from the API
        }.onAppear{
            viewModel.fetchMovies()
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}

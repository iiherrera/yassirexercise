//
//  MovieDetailView.swift
//  YassirExercise
//
//  Created by Iván Herrera on 12/26/23.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel
    var body: some View {
        Group {
            // We show the movie details if the viewmodel is not waiting for the API
            // and there is an actual MovieDetail model
            if !viewModel.isLoading, let movieDetail = viewModel.movieDetail {
                ScrollView {
                    VStack(spacing: 30) {
                        AsyncImage(url: movieDetail.imageURL) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200)
                        } placeholder: {
                            Image(systemName: Constants.moviePlaceholderPoster)
                                .resizable()
                                .frame(width: 200, height: 300)
                                .scaledToFill()
                                .foregroundColor(Color(UIColor.systemGray6))
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text(movieDetail.title)
                                .font(.system(size: 18, weight: .semibold))
                            Text(movieDetail.year)
                                .font(.system(size: 15))
                            Text(movieDetail.overview)
                                .font(.system(size: 15))
                        }
                        .padding([.leading, .trailing], 15)
                    }
                }
            // We show the loading view otherwise
            } else {
                LoadingView()
            }
        }
        // When the view appears, we ask the viewmodel to load the movie detail from the API
        .onAppear{
            viewModel.fetchMovieDetail()
        }
        // This is used to show an alert when viewmodel.alert gets published
        .alert(item: $viewModel.alert) { $0.builtAlert }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailViewModel(movieDetailID: 1))
    }
}

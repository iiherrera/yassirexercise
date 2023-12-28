//
//  MiscViews.swift
//  YassirExercise
//
//  Created by Iván Herrera on 12/27/23.
//

import SwiftUI

// This is a simple view we use to show progress
struct LoadingView: View {
    var body: some View {
        VStack(spacing: 10) {
            ProgressView()
            Text("loading")
                .padding(.bottom, 120)
        }
    }
}


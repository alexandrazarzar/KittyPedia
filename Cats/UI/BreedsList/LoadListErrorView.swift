//
//  LoadListErrorView.swift
//  Cats
//
//  Created by avz on 06/02/25.
//

import SwiftUI

struct LoadListErrorView: View {
    var tryAgainAction: () -> Void
    
    var body: some View {
        VStack {
            Image(ErrorViewConstants.Image.sadCat)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 80)
                .padding(.bottom)
            TryAgainView(tryAgainAction: tryAgainAction)
        }
        .padding()
    }
}

struct TryAgainView: View {
    var tryAgainAction: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(ErrorViewConstants.Text.errorMessage)
                    .foregroundColor(.pink)
                    .bold()
                
                Button(action: tryAgainAction) {
                    HStack {
                        Text(ErrorViewConstants.Text.tryAgain)
                            .bold()
                        Image(systemName: ErrorViewConstants.Image.tryAgainArrow)
                    }
                    .padding()
                    .frame(maxHeight: 35)
                    .foregroundColor(.white)
                    .background(
                        Color.pink
                    )
                    .cornerRadius(10)
                }
            }
            Spacer()
        }
    }
}

enum ErrorViewConstants {
    enum Text {
        static let errorMessage = "Unable to load data"
        static let tryAgain = "Try Again"
    }
    
    enum Image {
        static let sadCat = "sadCat"
        static let warning = "exclamationmark.triangle.fill"
        static let tryAgainArrow = "arrow.counterclockwise"
    }
}


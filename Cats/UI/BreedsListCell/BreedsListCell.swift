//
//  BreedsListCell.swift
//  Cats
//
//  Created by avz on 04/02/25.
//

import SwiftUI

struct BreedsListCellView: View {
    @ObservedObject var viewModel: BreedsListCellViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                imageView
                    .modifier(CustomShadow())
                breedInfo
                Spacer()
            }
        }
    }
    
    private var breedInfo: some View {
        VStack(alignment: .leading) {
            Text(viewModel.name)
                .bold()
            Text(viewModel.temperament)
                .multilineTextAlignment(.leading)
                .font(.footnote)
        }
    }
    
    private var imageView: some View {
        ZStack {
            if viewModel.imageURL != nil {
                AsyncImage(url: viewModel.imageURL) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFill()
                            .frame(width: Constants.Numbers.imageSize, height: Constants.Numbers.imageSize)
                            .cornerRadius(Constants.Numbers.cardCornerRadius)
                    } else if phase.error != nil {
                        placeHolderImage
                    } else {
                        ProgressView()
                    }
                }
            } else {
                placeHolderImage
            }
        }
        .frame(width: Constants.Numbers.imageSize, height: Constants.Numbers.imageSize)
        .padding(Constants.Numbers.imagePadding)
    }
    
    private var placeHolderImage: some View {
        ZStack {
            Color.gray
            Image(systemName: Constants.Image.placeholder)
                .foregroundColor(.white)
        }
        .cornerRadius(Constants.Numbers.cardCornerRadius)
    }
    
    struct Constants {
        enum Image {
            static let placeholder = "cat"
            static let chevronRight = "chevron.right"
        }
        
        enum Numbers {
            static let cardCornerRadius: CGFloat = 10
            static let imageSize: CGFloat = 100
            static let imagePadding: CGFloat = 10
        }
    }
}


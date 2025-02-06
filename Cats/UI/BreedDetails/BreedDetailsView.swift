//
//  BreedDetailsView.swift
//  Cats
//
//  Created by avz on 04/02/25.
//

import Foundation
import SwiftUI

struct BreedDetailsView: View {
    @ObservedObject var viewModel: BreedDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                breedImage
                breedDetails
            }
        }
        .navigationBarTitle(viewModel.breed.name, displayMode: .inline)
        .background(Color(UIColor.systemGroupedBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var breedImage: some View {
        ZStack {
            AsyncImage(url: viewModel.imageURL) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, minHeight: Constants.Numbers.imageMinHeight, maxHeight: Constants.Numbers.imageMaxHeight)
                } else {
                    placeHolderImage
                        .frame(maxWidth: .infinity, minHeight: Constants.Numbers.imageMinHeight, maxHeight: Constants.Numbers.imageMaxHeight)
                }
            }
        }
    }
    
    private var breedDetails: some View {
        VStack {
            ZStack {
                Color(UIColor.systemBackground)
                    .frame(maxWidth: .infinity)
                VStack(alignment: .leading) {
                    nameAndTemperament
                        .padding()
                    breedHighlightInfo
                    breedStory
                    characteristicsSection
                }
                .padding()
            }
            .cornerRadius(Constants.Numbers.cornerRadius)
            .modifier(CustomShadow())
            .padding(.top, Constants.Numbers.negativePadding)
        }
    }
    
    private var placeHolderImage: some View {
        ZStack {
            Color.gray
            Image(systemName: Constants.Image.placeholder)
                .foregroundColor(.white)
                .accessibilityIdentifier(Constants.Image.placeholderIdentifier)
        }
    }
    
    private var nameAndTemperament: some View {
        VStack(alignment: .leading) {
            Text(viewModel.breed.name)
                .font(.title)
                .fontWeight(.bold)
            
            Text(viewModel.breed.temperament)
                .font(.body)
                .italic()
                .multilineTextAlignment(.leading)
                .foregroundColor(.secondary)
        }
    }
    
    private var breedStory: some View {
        VStack(alignment: .leading) {
            Text(Constants.Text.moreAboutBreed)
                .font(.headline)
                .bold()

            Text(viewModel.breed.description)
                .foregroundColor(.secondary)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, Constants.Numbers.textPadding)
        }
        .padding()
    }
    
    private var breedHighlightInfo: some View {
        HStack {
            infoCard(icon: Constants.Emoji.origin, title: Constants.Text.origin, value: viewModel.origin)
            infoCard(icon: Constants.Emoji.lifespan, title: Constants.Text.lifespan, value: viewModel.lifeSpan)
            infoCard(icon: Constants.Emoji.weight, title: Constants.Text.weight, value: viewModel.metricWeight)
        }
        .padding(.bottom)
    }
    
    private func infoCard(icon: String, title: String, value: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.Numbers.cardCornerRadius)
                .fill(Color(.kittyPink).opacity(Constants.Numbers.cardOpacity))
            VStack {
                Text(icon)
                Text(title)
                    .bold()
                    .font(.caption)
                Text(value)
                    .font(.caption)
            }
            .padding()
        }
    }
    
    private var characteristicsSection: some View {
        VStack(alignment: .leading, spacing: Constants.Numbers.sectionSpacing) {
            Text(Constants.Text.characteristics)
                .font(.headline)
                .bold()
            
            ForEach(viewModel.characteristics, id: \.title) { characteristic in
                BreedCharacteristicView(title: characteristic.title, level: characteristic.level)
            }
        }
        .padding()
    }
    
    enum Constants {
        enum Text {
            static let moreAboutBreed = "💡 More about the breed"
            static let origin = "Origin"
            static let lifespan = "Lifespan"
            static let weight = "Weight"
            static let characteristics = "🔎 Breed Characteristics"
        }
        
        enum Image {
            static let placeholder = "cat"
            static let placeholderIdentifier = "placeHolderImage"
        }
        
        enum Emoji {
            static let origin = "🌎"
            static let lifespan = "🧶"
            static let weight = "🍽️"
        }
        
        enum Numbers {
            static let imageMinHeight: CGFloat = 300
            static let imageMaxHeight: CGFloat = 400
            static let cornerRadius: CGFloat = 30
            static let negativePadding: CGFloat = -20
            static let textPadding: CGFloat = 4
            static let cardCornerRadius: CGFloat = 15
            static let cardOpacity: CGFloat = 0.5
            static let sectionSpacing: CGFloat = 8
        }
    }
}

#Preview {
    let sampleBreed = Breed(breedResponse:
                                BreedResponse(
                                    id: "1",
                                    name: "Siberian",
                                    temperament: "Playful, Active",
                                    origin: "Russia",
                                    lifeSpan: "12-15",
                                    weight: BreedWeightResponse(imperial: "11-17", metric: "5-8"),
                                    description: "A friendly and intelligent cat breed.",
                                    adaptability: 5,
                                    affectionLevel: 5,
                                    childFriendly: 5,
                                    dogFriendly: 4,
                                    energyLevel: 4,
                                    intelligence: 5,
                                    socialNeeds: 4,
                                    strangerFriendly: 4,
                                    vocalisation: 3,
                                    image: CatImageResponse(id: "siberianImage", url: "https://cdn2.thecatapi.com/images/hBXicehMA.jpg")
                                )
    )
    
    let previewViewModel = BreedDetailsViewModel(breed: sampleBreed)
    BreedDetailsView(viewModel: previewViewModel)
}

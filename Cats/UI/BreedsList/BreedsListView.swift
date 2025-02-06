//
//  BreedsLisView.swift
//  Cats
//
//  Created by avz on 04/02/25.
//

import Foundation
import SwiftUI

struct BreedsListView: View {
    @ObservedObject var viewModel: BreedsListViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView()
                ZStack {
                    backgroundView
                    if !viewModel.breeds.isEmpty {
                        breedsContent
                    } else if viewModel.errorDescription != nil {
                        LoadListErrorView {
                            Task.detached { @MainActor in
                                await viewModel.loadMoreContent()
                            }
                        }
                    } else {
                        gettingCats
                    }
                }
            }
        }
        .accentColor(.pink)
    }
    
    private var backgroundView: some View {
        Color(UIColor.systemBackground)
            .ignoresSafeArea()
    }
    
    private var breedsContent: some View {
        List {
            ForEach(viewModel.breeds, id: \.self) { breed in
                breedNavigationLink(breed)
            }
            
            if viewModel.weGotToTheEnd {
                HStack {
                    Image(systemName: Constants.Image.cat)
                        .font(.title)
                    Text(Constants.Text.endMessage)
                        .font(.title)
                        .bold()
                }
                .padding()
            } else if !viewModel.isLoading {
                if viewModel.errorDescription == nil {
                    loadMoreButton
                } else {
                    TryAgainView(tryAgainAction: {
                        Task.detached { @MainActor in
                            await viewModel.loadMoreContent()
                        }
                    })
                    .padding()
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var loadMoreButton: some View {
        Button(action: {
            Task.detached { @MainActor in
                await viewModel.loadMoreContent()
            }
        }) {
            Text(Constants.Text.loadMore)
                .frame(maxWidth: .infinity)
                .bold()
                .padding(.vertical)
                .foregroundColor(.white)
                .modifier(CustomShadow())
                .background(
                    Color(.darkerKittyPink)
                )
                .cornerRadius(10)
        }
        .accessibilityIdentifier(Constants.Image.loadMoreButtonIdentifier)
        .padding()
    }
    
    private func breedNavigationLink(_ breed: Breed) -> some View {
        NavigationLink {
            let detailsVM = BreedDetailsViewModel(breed: breed)
            BreedDetailsView(viewModel: detailsVM)
        } label: {
            BreedsListCellView(viewModel: BreedsListCellViewModel(breed: breed))
        }
    }
    
    private var gettingCats: some View {
        VStack {
            Image(systemName: Constants.Image.cat)
            Text(Constants.Text.loading)
                .font(.title)
        }
        .foregroundColor(.gray)
    }
    
    enum Constants {
        enum Text {
            static let endMessage = "We got to the end!"
            static let loadMore = "Load More"
            static let errorMessage = "Unable to load data"
            static let tryAgain = "Try Again"
            static let loading = "Loading adorable cats..."
        }
        
        enum Image {
            static let cat = "cat.fill"
            static let sadCat = "sadCat"
            static let warning = "exclamationmark.triangle.fill"
            static let loadMoreButtonIdentifier = "LoadMoreButton"
            static let tryAgainArrow = "arrow.counterclockwise"
        }
    }
}

#Preview {
    let listVM = BreedsListViewModel()
    BreedsListView(viewModel: listVM)
        .task {
            await listVM.loadBreeds(byPage: 0)
        }
}

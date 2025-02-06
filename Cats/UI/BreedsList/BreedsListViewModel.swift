//
//  BreedsListViewModel.swift
//  Cats
//
//  Created by avz on 04/02/25.
//

import Foundation

@MainActor
class BreedsListViewModel: ObservableObject {
    @Published var errorDescription: String?
    @Published var breeds: [Breed] = []
    @Published var isLoading: Bool = false
    @Published var weGotToTheEnd: Bool = false
    
    var page: Int = 0
    private let catsService: CatsServiceProtocol
    
    var lastBreed: Breed? = nil

    init(catsService: CatsServiceProtocol = CatsService.shared) {
        self.catsService = catsService
    }
    
    func loadBreeds(byPage page: Int) async {
        self.errorDescription = nil
        do {
            let breedResponses = try await catsService.fetchBreeds(byPage: page)
            let newBreeds = breedResponses.map { Breed(breedResponse: $0) }

                if newBreeds.isEmpty {
                    self.weGotToTheEnd = true
                } else {
                    self.lastBreed = newBreeds.last
                    self.breeds.append(contentsOf: newBreeds)
                }
                self.isLoading = false
            } catch {
            self.isLoading = false
            self.errorDescription = error.localizedDescription
        }
    }
    
    func loadMoreContent() async {
        self.page += 1
        self.isLoading = true
        await loadBreeds(byPage: page)
    }
}

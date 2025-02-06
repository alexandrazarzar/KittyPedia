//
//  MockCatsService.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import Foundation

class MockCatsService: CatsServiceProtocol {
    func fetchBreeds(byPage page: Int) async throws -> [BreedResponse] {
        if page == 0 {
            return [
                BreedResponse (
                    id: "1",
                    name: "Abyssinian",
                    temperament: "Active, Energetic, Independent, Intelligent, Gentle",
                    origin: "Egypt",
                    lifeSpan: "9-15",
                    weight: BreedWeightResponse(imperial: "11-17", metric: "5-8"),
                    description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
                    adaptability: 4,
                    affectionLevel: 5,
                    childFriendly: 4,
                    dogFriendly: 3,
                    energyLevel: 5,
                    intelligence: 5,
                    socialNeeds: 4,
                    strangerFriendly: 4,
                    vocalisation: 3,
                    image: CatImageResponse(id: "siberianImage", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")
                ),
                
                BreedResponse (
                    id: "2",
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
                    image: nil
                )
            ]
        } else if page == 1 {
            return [
                BreedResponse (
                    id: "3",
                    name: "American Bobtail",
                    temperament: "Intelligent, Interactive, Lively, Playful, Sensitive",
                    origin: "US",
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
                    image: CatImageResponse(id: "hBXicehMA", url: "https://cdn2.thecatapi.com/images/hBXicehMA.jpg")
                )
            ]
        } else {
            return []
        }
    }
}

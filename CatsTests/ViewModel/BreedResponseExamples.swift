//
//  BreedResponseExamples.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import Foundation
@testable import Cats

struct BreedResponseExamples {
    static let completeBreed = BreedResponse (
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
        image: CatImageResponse(id: "siberianImage", url: "https://example.com/image.jpg")
    )
    
    static let missingBreedImage = BreedResponse (
        id: "2",
        name: "Abyssinian",
        temperament: "Curious, Active",
        origin: "Egypt",
        lifeSpan: "9-15 years",
        weight: BreedWeightResponse(imperial: "11-17", metric: "5-8"),
        description: "A highly energetic and playful breed.",
        adaptability: 4,
        affectionLevel: 5,
        childFriendly: 4,
        dogFriendly: 3,
        energyLevel: 5,
        intelligence: 5,
        socialNeeds: 4,
        strangerFriendly: 4,
        vocalisation: 3,
        image: nil
    )
}

//
//  Breed.swift
//  Cats
//
//  Created by avz on 03/02/25.
//

import Foundation

struct Breed: Decodable, Hashable {
    var id: String { breedResponse.id }
    var name: String { breedResponse.name }
    var temperament: String { breedResponse.temperament }
    var origin: String { breedResponse.origin }
    var lifeSpan: String { breedResponse.lifeSpan }
    var description: String { breedResponse.description }
    var metricWeight: String { breedResponse.weight.metric }
    var imperialWeight: String { breedResponse.weight.imperial }
    var adaptability: Int { breedResponse.adaptability }
    var affectionLevel: Int { breedResponse.affectionLevel }
    var childFriendly: Int { breedResponse.childFriendly }
    var dogFriendly: Int { breedResponse.dogFriendly }
    var energyLevel: Int { breedResponse.energyLevel }
    var intelligence: Int { breedResponse.intelligence }
    var socialNeeds: Int { breedResponse.socialNeeds }
    var strangerFriendly: Int { breedResponse.strangerFriendly }
    var vocalisation: Int { breedResponse.vocalisation }
    var imageURL: String? { breedResponse.image?.url }
    
    private let breedResponse: BreedResponse
    
    init(breedResponse: BreedResponse) {
        self.breedResponse = breedResponse
    }

    static func == (lhs: Breed, rhs: Breed) -> Bool {
        lhs.id == rhs.id
    }
}

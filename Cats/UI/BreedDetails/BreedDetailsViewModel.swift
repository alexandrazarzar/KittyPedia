//
//  BreedDetailsViewModel.swift
//  Cats
//
//  Created by avz on 04/02/25.
//

import Foundation

class BreedDetailsViewModel: ObservableObject {
    let breed: Breed
    
    var imageURL: URL? {
        if let url = breed.imageURL {
            return URL(string: url)
        } else {
            return nil
        }
    }
    
    var origin: String { breed.origin }
    var lifeSpan: String { "\(breed.lifeSpan) years" }
    var metricWeight: String { "\(breed.metricWeight) kg" }
    var imperialWeight: String { "\(breed.imperialWeight) lb" }
    
    var characteristics: [(title: String, level: Int)] {
        [
            ("Adaptability", breed.adaptability),
            ("Affection Level", breed.affectionLevel),
            ("Child Friendly", breed.childFriendly),
            ("Dog Friendly", breed.dogFriendly),
            ("Energy Level", breed.energyLevel),
            ("Intelligence", breed.intelligence),
            ("Social Needs", breed.socialNeeds),
            ("Stranger Friendly", breed.strangerFriendly),
            ("Vocalization", breed.vocalisation)
        ]
    }
    
    init(breed: Breed) {
        self.breed = breed
    }
}

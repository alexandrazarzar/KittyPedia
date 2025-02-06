//
//  BreedResponse.swift
//  Cats
//
//  Created by avz on 03/02/25.
//

import Foundation

struct BreedResponse: Decodable, Hashable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let lifeSpan: String
    let weight: BreedWeightResponse
    let description: String
    let adaptability: Int
    let affectionLevel: Int
    let childFriendly: Int
    let dogFriendly: Int
    let energyLevel: Int
    let intelligence: Int
    let socialNeeds: Int
    let strangerFriendly: Int
    let vocalisation: Int
    let image: CatImageResponse?
}

struct BreedWeightResponse: Decodable, Hashable {
    let imperial: String
    let metric: String
}

struct CatImageResponse: Decodable, Hashable {
    let id: String
    let url: String
}

//
//  BreedsListCellViewModel.swift
//  Cats
//
//  Created by avz on 04/02/25.
//

import Foundation

class BreedsListCellViewModel: ObservableObject {
    let breed: Breed
    
    var name: String {
        return breed.name
    }
    
    var temperament: String {
        return breed.temperament
    }
    
    var imageURL: URL? {
        if let url = breed.imageURL {
            return URL(string: url)
        } else {
            return nil
        }
    }
    
    init(breed: Breed) {
        self.breed = breed
    }
}

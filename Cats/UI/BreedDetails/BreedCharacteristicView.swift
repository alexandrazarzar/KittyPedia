//
//  BreedCharacteristicView.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import SwiftUI

struct BreedCharacteristicView: View {
    let title: String
    let level: Int
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
            Spacer()
            HStack(spacing: 5) {
                ForEach(1...5, id: \..self) { index in
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(index <= level ? Color(.kittyPink) : .gray.opacity(0.5))
                }
            }
        }
    }
}

#Preview {
    BreedCharacteristicView(title: "Cuteness", level: 5)
}

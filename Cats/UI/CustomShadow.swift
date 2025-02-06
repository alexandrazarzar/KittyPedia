//
//  CustomShadow.swift
//  Cats
//
//  Created by avz on 06/02/25.
//

import SwiftUI

struct CustomShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .gray.opacity(0.8), radius: 5)
    }
}

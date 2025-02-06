//
//  HeaderView.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(.kittyPink), Color(.darkerKittyPink)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .edgesIgnoringSafeArea(.top)

            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(Constants.Text.title)
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                            
                            Image(systemName: Constants.Image.paw)
                                .font(.title2)
                                .foregroundColor(.white)
                                .bold()
                        }
                        .modifier(CustomShadow())

                        Text(Constants.Text.subtitle)
                            .font(.title2)
                            .foregroundColor(.white.opacity(Constants.Numbers.subtitleColorOpacity))
                            .italic()
                    }
                    .padding(.leading)
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: Constants.Numbers.maxHeight)
    }
    
    enum Constants {
        enum Text {
            static let title = "KittyPedia"
            static let subtitle = "GET TO KNOW CAT BREEDS"
        }
        
        enum Image {
            static let paw = "pawprint.fill"
        }
        
        enum Numbers {
            static let subtitleColorOpacity: CGFloat = 0.9
            static let maxHeight: CGFloat = 120
        }
    }
}

#Preview {
    HeaderView()
}

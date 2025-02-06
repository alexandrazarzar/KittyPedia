//
//  CatsApp.swift
//  Cats
//
//  Created by avz on 03/02/25.
//

import SwiftUI
import SwiftData

@main
struct CatsApp: App {
    init() {
        if CommandLine.arguments.contains("--uitesting") {
            CatsService.shared = MockCatsService()
        } else if CommandLine.arguments.contains("--uitesting-error") {
            CatsService.shared = MockFailingCatsService()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            let listVM = BreedsListViewModel()
            BreedsListView(viewModel: listVM)
                .task {
                    await listVM.loadBreeds(byPage: 0)
                }
        }
    }
}

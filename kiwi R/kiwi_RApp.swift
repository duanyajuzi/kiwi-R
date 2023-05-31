//
//  kiwi_RApp.swift
//  kiwi R
//
//  Created by jarvis on 2023/5/20.
//

import SwiftUI

@main
struct kiwi_RApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

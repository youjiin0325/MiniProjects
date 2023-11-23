//
//  caloriesAppApp.swift
//  caloriesApp
//
//  Created by YOU on 11/22/23.
//

import SwiftUI

@main
struct caloriesAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

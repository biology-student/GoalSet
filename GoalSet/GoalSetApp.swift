//
//  GoalSetApp.swift
//  GoalSet
//
//  Created by Yoshikazu Tsuka on 2021/05/26.
//

import SwiftUI

@main
struct GoalSetApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

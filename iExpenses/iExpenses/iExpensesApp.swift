//
//  iExpensesApp.swift
//  iExpenses
//
//  Created by Lucas Parreira on 9/07/21.
//

import SwiftUI

@main
struct iExpensesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

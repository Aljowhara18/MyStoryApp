//
//  MystoryApp.swift
//  Mystory
//
//  Created by Wareef Saeed Alzahrani on 11/06/1447 AH.
//
import SwiftUI
import SwiftData

@main
struct MystoryApp: App {

    init() {
        // نجبر التطبيق يبدأ بالعربية
        UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()    }

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            Splash()
                .preferredColorScheme(.light)
        }
        .modelContainer(sharedModelContainer)
    }
}

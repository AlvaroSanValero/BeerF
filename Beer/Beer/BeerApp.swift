//
//  BeerApp.swift
//  Beer
//
//  Created by alumno on 1/12/23.
//

import SwiftUI

@main
struct BeerApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onAppear {
                    DataManager.shared.loadDataFromCoreData()
                    
                }
        }
    }
}

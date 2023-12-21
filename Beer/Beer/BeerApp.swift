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
            ContentView(appState: appState)
                .onAppear {
                    DataManager.shared.loadDataFromCoreData(appState: appState)
                }
        }
    }
}
class AppState: ObservableObject {
    @Published var manufacturers: [Manufacturer] = []
    @Published var beers: [Beer] = []
}


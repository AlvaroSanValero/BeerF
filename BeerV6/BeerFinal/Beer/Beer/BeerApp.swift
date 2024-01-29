//
//  BeerApp.swift
//  Beer
//
//  Created by Álvaro San Valero Benito on 1/12/23.
//

import SwiftUI

// Define la aplicación principal
@main
struct BeerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(BeerModel())
                .onChange(of: ScenePhase.background, perform: { phase in
                    if phase == .background {
                        // Guardar datos al entrar en segundo plano
                        BeerModel().saveDataToDocuments()
                    }
                })
        }
    }
}

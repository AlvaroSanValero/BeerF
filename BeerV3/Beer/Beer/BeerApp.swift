//
//  BeerApp.swift
//  Beer
//
//  Created by alumno on 1/12/23.
//

import SwiftUI

// Define la aplicación principal
@main
struct BeerApp: App {
    // Cuerpo de la aplicación
    var body: some Scene {
        // Define una escena de ventana
        WindowGroup {
            // Crea la vista principal (ContentView) y la configura con un objeto BeerModel como entorno
            ContentView().environmentObject(BeerModel())
        }
    }
}

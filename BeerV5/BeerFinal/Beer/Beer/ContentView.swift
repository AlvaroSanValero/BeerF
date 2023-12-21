//
//  ContentView.swift
//  Cervezas
//
//  Created by Álvaro San Valero Benito on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Fondo color cerveza
            Color(red: 255 / 255, green: 212 / 255, blue: 94 / 255)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                TabView {
                    // MainView con icono diferente
                    MainView()
                        .tabItem {
                            Image(systemName: "cart.fill")
                            Text("Inicio")
                        }
                }
                .accentColor(.white) // Color del texto de la pestaña
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

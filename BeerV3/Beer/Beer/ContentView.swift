//
//  ContentView.swift
//  Cervezas
//
//  Created by alumno on 1/12/23.
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
                    
                    /*// ProfileView
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Perfil")
                        }
                    
                    // SettingsView
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gearshape.fill")
                            Text("Configuración")
                        }*/
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

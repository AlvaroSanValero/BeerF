//
//  ContentView.swift
//  Cervezas
//
//  Created by alumno on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var appState = AppState()

    var body: some View {
        NavigationView {
            List {
                // Sección para fabricantes nacionales
                Section(header: Text("Nacionales")) {
                    ForEach(appState.manufacturers.filter { $0.isNational }) { manufacturer in
                        NavigationLink(destination: ManufacturerDetailView(manufacturer: manufacturer)) {
                            ManufacturerRow(manufacturer: manufacturer)
                        }
                    }
                }
                // Sección para fabricantes importados
                Section(header: Text("Importadas")) {
                    ForEach(appState.manufacturers.filter { !$0.isNational }) { manufacturer in
                        NavigationLink(destination: ManufacturerDetailView(manufacturer: manufacturer)) {
                            ManufacturerRow(manufacturer: manufacturer)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle()) // Estilo de la lista
            .navigationTitle("Fabricantes") // Título de la barra de navegación
            .navigationBarItems(trailing: NavigationLink(destination: AddManufacturerView()) {
                Text("Añadir fabricante") // Botón para añadir fabricante
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

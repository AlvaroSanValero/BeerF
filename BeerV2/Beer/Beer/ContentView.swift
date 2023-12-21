//
//  ContentView.swift
//  Cervezas
//
//  Created by alumno on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    Section(header: Text("Nacionales")) {
                        ForEach(appState.manufacturers.filter { $0.isNational }) { manufacturer in
                            NavigationLink(destination: ManufacturerDetailView(appState: appState, manufacturer: manufacturer)) {
                                ManufacturerRow(manufacturer: manufacturer)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) { _ in
                                // Lógica para eliminar fabricante y sus cervezas
                                appState.removeManufacturer(manufacturer)
                            }
                        }
                    }

                    Section(header: Text("Importadas")) {
                        ForEach(appState.manufacturers.filter { !$0.isNational }) { manufacturer in
                            NavigationLink(destination: ManufacturerDetailView(appState: appState, manufacturer: manufacturer)) {
                                ManufacturerRow(manufacturer: manufacturer)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) { _ in
                                // Lógica para eliminar fabricante y sus cervezas
                                appState.removeManufacturer(manufacturer)
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Fabricantes")
                .navigationBarItems(trailing: NavigationLink(destination: AddManufacturerView(appState: appState)) {
                    Text("Añadir fabricante")
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: AppState()) // Utiliza @StateObject en lugar de environmentObject
    }
}

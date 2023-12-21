//
//  ManufacterDetailView.swift
//  Beer
//
//  Created by alumno on 1/12/23.
//

import SwiftUI

struct ManufacturerDetailView: View {
    @StateObject var appState: AppState
    var manufacturer: Manufacturer

    var body: some View {
        List {
            Section(header: Text("Lager")) {
                ForEach(manufacturer.beers.filter { $0.type == .lager }) { beer in
                    NavigationLink(destination: BeerDetailView(editedBeer: $appState.editedBeer)) {
                        BeerRow(beer: beer)
                    }
                }
            }

            Section(header: Text("Pilsen")) {
                ForEach(manufacturer.beers.filter { $0.type == .pilsen }) { beer in
                    NavigationLink(destination: BeerDetailView(editedBeer: $appState.editedBeer)) {
                        BeerRow(beer: beer)
                    }
                }
            }

            // ... Otras secciones para diferentes tipos de cervezas

        }
        .navigationBarItems(trailing: HStack {
            Button("Añadir cerveza") {
                // Lógica para agregar cerveza
                appState.editedBeer = Beer(type: .lager) // Inicializar con tipo predeterminado
            }
            EditButton()
        })
        .navigationTitle(manufacturer.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ManufacturerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Vista de previsualización con un fabricante de muestra
        ManufacturerDetailView(manufacturer: Manufacturer(name: "Sample", logo: "logo", beers: []))
    }
}



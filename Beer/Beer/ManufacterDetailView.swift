//
//  ManufacterDetailView.swift
//  Beer
//
//  Created by alumno on 1/12/23.
//

import SwiftUI

struct ManufacturerDetailView: View {
    @ObservedObject var appState = AppState()
    var manufacturer: Manufacturer

    var body: some View {
        // Lista que muestra las cervezas del fabricante
        List {
            ForEach(appState.manufacturer.beers) { beer in
                // Enlace de navegación para mostrar detalles de cada cerveza
                NavigationLink(destination: BeerDetailView(beer: beer)) {
                    BeerRow(beer: beer) // Vista de fila para cada cerveza
                }
            }
        }
        .listStyle(InsetGroupedListStyle()) // Estilo de lista
        .navigationTitle(manufacturer.name) // Título de la barra de navegación con el nombre del fabricante
        .navigationBarItems(trailing: Button("Añadir cerveza") {
            // Lógica para agregar cerveza (a implementar)
        })
    }
}

struct ManufacturerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Vista de previsualización con un fabricante de muestra
        ManufacturerDetailView(manufacturer: Manufacturer(name: "Sample", logo: "logo", beers: []))
    }
}



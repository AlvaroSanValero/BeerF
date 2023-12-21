//
//  BeerRow.swift
//  Beer
//
//  Created by alumno on 1/12/23.
//

import SwiftUI

struct BeerRow: View {
    var beer: BeerRow

    var body: some View {
        HStack {
            // Imagen de la cerveza (reemplaza "systemName" con la carga real de la imagen)
            Image(systemName: beer.image ?? "defaultBeerImage")
                .resizable()
                .frame(width: 30, height: 30)

            // Texto que muestra el nombre de la cerveza
            Text(beer.name ?? "Unknown Beer")
        }
    }
}

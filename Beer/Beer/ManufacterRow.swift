//
//  ManufacterRow.swift
//  Beer
//
//  Created by alumno on 1/12/23.
//

import SwiftUI

struct ManufacturerRow: View {
    var manufacturer: ManufacturerRow

    var body: some View {
        HStack {
            // Imagen del fabricante (reemplaza "systemName" con la carga real de la imagen)
            Image(systemName: manufacturer.logo ?? "defaultManufacturerLogo")
                .resizable()
                .frame(width: 30, height: 30)
            
            // Texto que muestra el nombre del fabricante
            Text(manufacturer.name ?? "Unknown Manufacturer")
        }
    }
}

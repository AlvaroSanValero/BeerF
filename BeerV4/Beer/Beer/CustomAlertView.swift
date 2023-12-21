//
//  CustomAlertView.swift
//  Beer
//
//  Created by Álvaro San Valero Benito on 21/12/23.
//

import SwiftUI

struct CustomAlertView: View {
    var body: some View {
        VStack {
            Text("Error")
                .foregroundColor(Color.black)
            Text("Todos los campos son obligatorios.")
                .foregroundColor(Color.black)
            Button("OK") {
                // Acción al presionar OK
            }
            .foregroundColor(Color.white)
        }
        .padding()
        .background(Color.red)
        .cornerRadius(10)
    }
}

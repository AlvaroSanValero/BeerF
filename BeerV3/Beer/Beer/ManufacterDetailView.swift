//
//  ManufacterDetailView.swift
//  Beer
//
//  Created by alumno on 1/12/23.
//

import SwiftUI

struct ManufacturerDetailView: View {
    @EnvironmentObject var beermodel: BeerModel
    @State private var showListBeerView = false
    @State private var nameManufacturer = ""
    @State private var searchText = ""
    var title: String
    @Environment(\.dismiss) var dismiss
    @State private var isShowingAddManufacturerView = false

    var body: some View {
        ZStack {
            // Cambiado el fondo a un color dorado de cerveza
            Color(red: 255 / 255, green: 212 / 255, blue: 94 / 255)
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left").foregroundColor(Color.white)
                    }
                    .padding()

                    Text(title)
                        .underline()
                        .foregroundColor(Color.white)
                        .font(.custom("", fixedSize: 40))
                        .padding()

                    Spacer()
                }

                // Cambiada la barra de búsqueda a un TextField simple
                TextField("Buscar", text: $searchText)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(beermodel.manufacturers.filter {
                            searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText)
                        }, id: \.name) { item in
                            if item.country == beermodel.selectedCountry {
                                HStack {
                                    // Utiliza una función para cargar la imagen desde la cadena base64
                                    beermodel.loadImageFromBase64(item.photo)
                                        .resizable()
                                        .frame(width: 85, height: 85)

                                    Text(item.name)
                                    Spacer()
                                    Text(item.country)
                                }
                                .padding()
                                .frame(width: 350.0, height: 100.0)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                                .onTapGesture {
                                    showListBeerView.toggle()
                                    nameManufacturer = item.name
                                }
                            }
                        }
                    }
                }

                Spacer()

                Button(action: {
                    isShowingAddManufacturerView = true
                }) {
                    Text("+ Add Manufacturer")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 36 / 255, green: 75 / 255, blue: 136 / 255))
                        .cornerRadius(10)
                }
                .padding()
                .fullScreenCover(isPresented: $isShowingAddManufacturerView) {
                    AddManufacturerForm()
                        .environmentObject(beermodel) // Asegúrate de pasar el objeto de modelo aquí
                }
            }
        }
        .fullScreenCover(isPresented: $showListBeerView, content: {
            BeerDetailView(nameManufacturer: nameManufacturer)
                .environmentObject(beermodel) // Asegúrate de pasar el objeto de modelo aquí
        })
    }
}

struct ManufacturerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ManufacturerDetailView(title: "NACIONALES").environmentObject(BeerModel())
    }
}

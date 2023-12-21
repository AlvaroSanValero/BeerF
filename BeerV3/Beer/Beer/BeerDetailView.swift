//
//  BeerDetailView.swift
//  Beer
//
//  Created by alumno on 20/12/23.
//

import SwiftUI

struct BeerDetailView: View {
    @EnvironmentObject var beermodel: BeerModel
    @Environment(\.dismiss) var dismiss
    var nameManufacturer: String
    @State private var selectedOrder: OrderOption = .name
    @State private var selectedBeer: Beer? = nil
    @State private var isShowingDetails: Bool = false

    var body: some View {
        ZStack {
            // Fondo de la pantalla
            Color(red: 0 / 255, green: 54 / 255, blue: 142 / 255).opacity(0.73)
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    // Botón para cerrar la vista
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left").foregroundColor(Color.white)
                    }
                    .padding()

                    // Título de la vista
                    Text(nameManufacturer)
                        .underline()
                        .foregroundColor(Color.white)
                        .font(.custom("", fixedSize: 40))
                        .padding()

                    Spacer()
                }

                // Selector de orden para las cervezas
                Picker("Ordenar por", selection: $selectedOrder) {
                    ForEach(OrderOption.allCases) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .foregroundColor(Color.white)

                // Lista de secciones de cervezas
                List {
                    ForEach(groupedBeers(), id: \.0) { (category, beers) in
                        Section(header: Text(category).foregroundColor(Color.white)) {
                            ForEach(beers.sorted(by: sortingComparator()), id: \.id) { beer in
                                // Vista de cada cerveza en la lista
                                beermodel.loadImageFromBase64(beer.photo)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(5)
                                Text(beer.name)
                                    .foregroundColor(Color.white)
                                    .onTapGesture {
                                        selectedBeer = beer
                                        isShowingDetails.toggle()
                                    }
                            }
                        }
                    }
                }.background(Color(red: 0 / 255, green: 54 / 255, blue: 142 / 255).opacity(0.73))
                Spacer()
                // Botón para agregar una nueva cerveza (añadir lógica)
                Button(action: {
                    // Agrega la lógica para agregar una nueva cerveza
                }) {
                    Text("AddBeer").foregroundColor(Color.white)
                    Image(systemName: "plus").foregroundColor(Color.white)
                }
            }.sheet(isPresented: $isShowingDetails) {
                // Hoja de detalles para la cerveza seleccionada
                if let selectedBeer = selectedBeer {
                    BeerDetailView(nameManufacturer: selectedBeer.name)
                        .environmentObject(beermodel)  // Añade el objeto de entorno aquí
                }
            }
        }
        .navigationBarTitle("Detalles", displayMode: .inline)
    }

    // Función para agrupar las cervezas por categoría
    private func groupedBeers() -> [(String, [Beer])] {
        let grouped = Dictionary(grouping: beermodel.beers, by: { $0.beerType })
        return grouped.map { ($0.key, $0.value) }
    }

    // Función para obtener el comparador de orden según la opción seleccionada
    private func sortingComparator() -> (Beer, Beer) -> Bool {
        switch selectedOrder {
        case .name:
            return { $0.name < $1.name }
        case .alcoholContent:
            return { $0.alcoholContent < $1.alcoholContent }
        case .calorieExpense:
            return { $0.calorieExpense < $1.calorieExpense }
        }
    }

    // Enumeración para las opciones de orden
    enum OrderOption: String, CaseIterable, Identifiable {
        case name = "Nombre"
        case alcoholContent = "Graduación Alcohólica"
        case calorieExpense = "Aporte Calórico"

        var id: OrderOption { self }
    }
}

struct BeerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetailView(nameManufacturer: "Manufacturer")
            .environmentObject(BeerModel())  // Asegúrate de proporcionar el modelo de cerveza
    }
}

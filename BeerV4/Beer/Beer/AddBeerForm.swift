//
//  AddBeerForm.swift
//  Beer
//
//  Created by Álvaro San Valero Benito on 21/12/23.
//

import SwiftUI

struct AddBeerForm: View {
    // Propiedades de estado para almacenar la información de la nueva cerveza
    @State private var name = ""
    @State private var beerType = ""
    @State private var alcoholContent = ""
    @State private var calorieExpense = ""
    @State private var image: UIImage?
    @State private var isShowingImagePicker = false
    @State private var showingAlert = false

    // Referencia al ViewModel para agregar nuevas cervezas
    @EnvironmentObject var beermodel: BeerModel

    // Entorno para permitir la acción de cerrar el formulario
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                // Sección para seleccionar la imagen de la cerveza
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    } else {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            .foregroundColor(Color.white.opacity(0.8))
                    }
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePicker(sourceType: .photoLibrary) { image in
                        self.image = image
                    }
                }
                .padding(.bottom, 20)

                // Sección para ingresar detalles de la nueva cerveza
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Nombre", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Tipo de cerveza", text: $beerType)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Graduación Alcohólica", text: $alcoholContent)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)

                    TextField("Aporte Calórico", text: $calorieExpense)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding(.horizontal, 20)

                Spacer()

                // Botón para agregar la nueva cerveza
                Button(action: {
                    if !name.isEmpty && !beerType.isEmpty && !alcoholContent.isEmpty && !calorieExpense.isEmpty {
                        let imageData: Data?
                        if let image = image {
                            imageData = image.jpegData(compressionQuality: 0.8)
                        } else {
                            // Establece una imagen predeterminada si no se selecciona ninguna
                            let defaultImage = UIImage(named: "ImagesB/defaultImage")
                            imageData = defaultImage?.jpegData(compressionQuality: 0.8)
                        }

                        if let imageData = imageData {
                            let base64String = imageData.base64EncodedString()
                            let alcoholContentDouble = Double(alcoholContent) ?? 0.0
                            let calorieExpenseDouble = Double(calorieExpense) ?? 0.0

                            // Obtén el fabricante seleccionado del modelo
                            let selectedManufacturer = beermodel.manufacturers.first { $0.country == beermodel.selectedCountry }

                            // Asegúrate de que se haya encontrado un fabricante
                            if let manufacturer = selectedManufacturer {
                                beermodel.addBeer(
                                    name: name,
                                    photo: base64String,
                                    manufacturer: manufacturer.name,
                                    beerType: beerType,
                                    alcoholContent: alcoholContentDouble,
                                    calorieExpense: calorieExpenseDouble
                                )
                                dismiss()
                            } else {
                                // Manejar el caso en que no se encuentra el fabricante seleccionado
                                showingAlert = true
                            }
                        } else {
                            showingAlert = true
                        }
                    } else {
                        showingAlert = true
                    }
                }) {
                    Text("Añadir cerveza")
                        .foregroundColor(Color.black) // Cambiado el color del texto a negro
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 255 / 255, green: 212 / 255, blue: 94 / 255)) // Color de fondo de la cerveza
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)

                // Manejo de alerta en caso de campos incompletos
                .sheet(isPresented: $showingAlert) {
                                   CustomAlertView()
                               }
            }
            .padding()
            .background(Color(red: 0 / 255, green: 54 / 255, blue: 142 / 255).opacity(0.73).edgesIgnoringSafeArea(.all))

            // Configuración de la barra de navegación
            .navigationBarTitle("Nueva Cerveza", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(Color.white)
            })
        }
    }
}

struct AddBeerForm_Previews: PreviewProvider {
    static var previews: some View {
        AddBeerForm().environmentObject(BeerModel())
    }
}

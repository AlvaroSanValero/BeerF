//
//  AddManufacterForm.swift
//  Beer
//
//  Created by alumno on 20/12/23.
//

import SwiftUI

struct AddManufacturerForm: View {
    // Propiedades de estado para almacenar la información del nuevo fabricante
    @State private var name = ""
    @State private var country = ""
    @State private var image: UIImage?
    @State private var isShowingImagePicker = false
    @State private var showingAlert = false
    
    // Referencia al ViewModel para agregar nuevos fabricantes
    @EnvironmentObject var beermodel: BeerModel
    
    // Entorno para permitir la acción de cerrar el formulario
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                // Sección para seleccionar la imagen del fabricante
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
                
                // Sección para ingresar el nombre y país del fabricante
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Nombre", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("País", text: $country)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Botón para agregar el nuevo fabricante
                Button(action: {
                    if !name.isEmpty && !country.isEmpty {
                        let imageData: Data?
                        if let image = image {
                            imageData = image.jpegData(compressionQuality: 0.8)
                        } else {
                            // Establece una imagen predeterminada si no se selecciona ninguna
                            let defaultImage = UIImage(named: "defaultImage")
                            imageData = defaultImage?.jpegData(compressionQuality: 0.8)
                        }
                        
                        if let imageData = imageData {
                            let base64String = imageData.base64EncodedString()
                            beermodel.addManufacturer(name: name, photo: base64String, country: country)
                            dismiss()
                        } else {
                            showingAlert = true
                        }
                    } else {
                        showingAlert = true
                    }
                }) {
                    Text("Añadir fabricante")
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 36 / 255, green: 75 / 255, blue: 136 / 255))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                
                // Manejo de alerta en caso de campos incompletos
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text("Todos los campos son obligatorios."), dismissButton: .default(Text("OK")))
                        .foregroundColor(Color.black) // Cambiado el color del texto a negro
                        .background(Color.red) // Cambiado el color de fondo a rojo
                }
            }
            .padding()
            .background(Color(red: 0 / 255, green: 54 / 255, blue: 142 / 255).opacity(0.73).edgesIgnoringSafeArea(.all))
            
            // Configuración de la barra de navegación
            .navigationBarTitle("Nuevo Fabricante", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(Color.white)
            })
        }
    }
}

struct AddManufacturerForm_Previews: PreviewProvider {
    static var previews: some View {
        AddManufacturerForm().environmentObject(BeerModel())
    }
}

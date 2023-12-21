//
//  BeerModel.swift
//  Beer
//
//  Created by alumno on 20/12/23.
//

import Foundation
import UIKit
import SwiftUI

// MARK: - Model

// Estructura que representa una cerveza
struct Beer: Identifiable, Decodable {
    var id = UUID()
    var name: String
    var photo: String
    var manufacturer: String
    var beerType: String
    var alcoholContent: Double
    var calorieExpense: Double
}

// Estructura que representa un fabricante
struct Manufacturer: Identifiable, Decodable {
    var id = UUID()
    let name: String
    let photo: String
    let country: String
}

// MARK: - ViewModel

// Clase que maneja la lógica de la aplicación y almacena los datos
class BeerModel: ObservableObject {
    // Lista de cervezas
    @Published var beers: [Beer] = []
    // Lista de fabricantes
    @Published var manufacturers: [Manufacturer] = []
    // Lista de países
    @Published var countries: [String] = ["Spain", "Germany", "Belgium", "USA", "Mexico", "Japan","China", "Italy"]
    // País seleccionado
    @Published var selectedCountry: String = "España"
    
    // Inicialización, carga de datos al crear una instancia
    init() {
        loadData()
    }
    
    // MARK: - Data Loading
    
    // Carga datos de cervezas y fabricantes desde archivos JSON
    func loadData() {
        loadBeers()
        loadManufacturers()
    }
    
    // Carga datos de cervezas desde archivo JSON
    private func loadBeers() {
        if let url = Bundle.main.url(forResource: "Beers", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Beer].self, from: data)
                self.beers = jsonData
            } catch {
                print("Error loading Beers JSON data: \(error)")
            }
        }
    }
    
    // Carga datos de fabricantes desde archivo JSON
    private func loadManufacturers() {
        if let url = Bundle.main.url(forResource: "Manufacters", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Manufacturer].self, from: data)
                self.manufacturers = jsonData
            } catch {
                print("Error loading Manufacturers JSON data: \(error)")
            }
        }
    }
    
    // MARK: - Data Manipulation
    
    // Agrega un nuevo fabricante a la lista
    func addManufacturer(name: String, photo: String, country: String) {
        let newManufacturer = Manufacturer(name: name, photo: photo, country: country)
        manufacturers.append(newManufacturer)
    }
    
    // Agrega una nueva cerveza a la lista
    func addBeer(name: String, photo: String, manufacturer: String, beerType: String, alcoholContent: Double, calorieExpense: Double) {
        let newBeer = Beer(name: name, photo: photo, manufacturer: manufacturer, beerType: beerType, alcoholContent: alcoholContent, calorieExpense: calorieExpense)
        beers.append(newBeer)
    }
    
    // MARK: - Image Handling
    
    // Convierte una imagen a una cadena Base64
    func convertImageToBase64String(img: UIImage) -> String {
        let imageData = img.jpegData(compressionQuality: 1.0)
        return imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
    }
    
    // Carga una imagen desde una cadena Base64 y la convierte en un objeto Image
    func loadImageFromBase64(_ base64String: String) -> Image {
        guard let data = Data(base64Encoded: base64String),
              let uiImage = UIImage(data: data) else {
            return Image(systemName: "photo")
        }
        return Image(uiImage: uiImage)
    }
}

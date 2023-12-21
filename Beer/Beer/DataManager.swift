//
//  DataManager.swift
//  Beer
//
//  Created by alumno on 1/12/23.
//
import CoreData

class DataManager {
    // Singleton para manejar los datos de la aplicación
    static let shared = DataManager()

    // Lazy-loaded persistent container para CoreData
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "YourDataModelName")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // Función para guardar datos en CoreData
    func saveDataToCoreData() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("Error saving CoreData context: \(error.localizedDescription)")
        }
    }

    // Función para cargar datos desde CoreData
    func loadDataFromCoreData(appState: AppState) {
        let context = persistentContainer.viewContext

        // Cargar fabricantes desde CoreData
        let fetchRequest: NSFetchRequest<ManufacturerEntity> = ManufacturerEntity.fetchRequest()
        do {
            let manufacturers = try context.fetch(fetchRequest)
            // Actualizar el estado de la aplicación con los fabricantes cargados
            appState.manufacturers = manufacturers.map { Manufacturer(manufacturerEntity: $0) }
        } catch {
            print("Error fetching manufacturers: \(error.localizedDescription)")
        }

        // Cargar cervezas desde CoreData
        let beerFetchRequest: NSFetchRequest<BeerEntity> = BeerEntity.fetchRequest()
        do {
            let beers = try context.fetch(beerFetchRequest)
            // Asociar las cervezas a sus respectivos fabricantes en el estado de la aplicación
            for beer in beers {
                if let manufacturer = appState.manufacturers.first(where: { $0.id == beer.manufacturer?.objectID }) {
                    manufacturer.beers.append(Beer(beerEntity: beer))
                }
            }
        } catch {
            print("Error fetching beers: \(error.localizedDescription)")
        }
    }

    // Función para cargar datos desde archivos en el bundle
    func loadDataFromBundle(appState: AppState) {
        // Implementa la lógica para cargar datos desde archivos en el bundle
        // y guardarlos en la carpeta Documents si es necesario

        guard let bundleURL = Bundle.main.url(forResource: "YourDataFileName", withExtension: "json") else {
            print("No se encontró el archivo en el bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: bundleURL)
            let decoder = JSONDecoder()
            let loadedData = try decoder.decode(YourDataModel.self, from: data)

            // Aquí asignarías los datos cargados al appState
            // appState.manufacturers = loadedData.manufacturers
            // appState.beers = loadedData.beers

            // Guardar datos en CoreData
            saveDataToCoreData()

        } catch {
            print("Error cargando datos desde el bundle: \(error.localizedDescription)")
        }
    }

    // Función para verificar si los datos ya existen en la carpeta Documents
    private func dataExistsInDocuments() -> Bool {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent("YourDataFileName.json")
        return FileManager.default.fileExists(atPath: fileURL.path)
    }

    // Función para copiar datos desde el bundle a la carpeta Documents
    private func copyDataToDocumentsIfNeeded() {
        guard !dataExistsInDocuments() else { return }

        guard let bundleURL = Bundle.main.url(forResource: "YourDataFileName", withExtension: "json"),
              let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("No se encontraron los archivos de origen o destino.")
            return
        }

        let destinationURL = documentsURL.appendingPathComponent("YourDataFileName.json")

        do {
            try FileManager.default.copyItem(at: bundleURL, to: destinationURL)
        } catch {
            print("Error copiando datos al directorio Documents: \(error.localizedDescription)")
        }
    }

    // Función para cargar datos (llamada desde la App al inicio)
    func loadData(appState: AppState) {
        // Verificar si los datos ya existen en Documents
        if dataExistsInDocuments() {
            // Cargar datos desde la carpeta Documents
            loadDataFromCoreData(appState: appState)
        } else {
            // Copiar datos desde el bundle a la carpeta Documents
            copyDataToDocumentsIfNeeded()
            // Cargar datos desde archivos en el bundle
            loadDataFromBundle(appState: appState)
        }
    }
}

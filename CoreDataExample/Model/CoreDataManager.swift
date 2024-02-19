//
//  CoreDataManager.swift
//  CoreDataExample
//
//  Created by apple on 19.02.2024.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init () { }
    
    var notes = [Note]()
    
    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataExample")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    //MARK: CRUD
    
    //Create
    func createNote(title: String) {
        let someNote = Note(context: persistentContainer.viewContext)
        
        someNote.id = UUID().uuidString
        someNote.date = Date()
        someNote.title = title
        
        saveContext()
        readNote()
    }
    
    //Read
    func readNote() {
        let request = Note.fetchRequest()
        
        do {
            let notes = try persistentContainer.viewContext.fetch(request)
            self.notes = notes
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //Read Specific Note
    func readSpecificNote(id: String) -> Note? {
        let request = Note.fetchRequest()
        request.predicate = NSPredicate(format: "id==%@", id)
        do {
            let notes = try persistentContainer.viewContext.fetch(request)
            return notes.first
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    //Update
    func updateNote(id: String, newTitle: String) {
        guard let note = readSpecificNote(id: id) else { print("Нет заметки") ; return }
        note.title = newTitle
        note.date = Date()
        
        saveContext()
        readNote()
    }
    
    //Delete
    func deleteNote(id: String) {
        guard let note = readSpecificNote(id: id) else { print("Нет заметки") ; return }
        persistentContainer.viewContext.delete(note)
        saveContext()
        readNote()
    }
    
}

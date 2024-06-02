//
//  StorageManager.swift
//  Vulcano
//
//  Created by Bema on 2/6/24.
//

import Foundation
import UIKit
import CoreData

// MARK: - CRUD

public final class StorageManager: NSObject {
    
    var friends = [List]()
    
    public static let shared = StorageManager()
    private override init() { }
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
        
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func createFriend(name: String, dateOfBirth: String, old: String) {
        guard let friendEntityDescription = NSEntityDescription.entity(forEntityName: "List", in: context) else { return }
        let friend = List(entity: friendEntityDescription, insertInto: context)
        friend.name = name
        friend.dateOfBirth = dateOfBirth
        friend.old = old
        
        appDelegate.saveContext()
    }
    
    public func fetchFriends() -> [List] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        do {
            return try context.fetch(fetchRequest) as! [List]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    public func fetchFriend(with id: Int16, date: String) -> List? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        do {
            let friends = try? context.fetch(fetchRequest) as? [List]
            return friends?.first(where: { $0.id == id && $0.dateOfBirth == date })
        }
    }
    
    public func updateFriend(newName: String, newData: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        do {
            guard let friends = try? context.fetch(fetchRequest) as? [List],
                  let friend = friends.first(where: { $0.dateOfBirth == newData }) else { return }
            friend.name = newName
            friend.dateOfBirth = newData
        }
        appDelegate.saveContext()
    }
    
    public func deleteAllFriends() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        do {
            let friends = try? context.fetch(fetchRequest) as? [List]
            friends?.forEach { context.delete($0) }
        }
        appDelegate.saveContext()
    }
    
    public func deleteFriend(with id: Int16) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        do {
            guard let friends = try? context.fetch(fetchRequest) as? [List],
                  let friend = friends.first(where: { $0.id == id }) else { return }
            context.delete(friend)
        }
        appDelegate.saveContext()
    }
    
    
    // MARK:  - Save
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ListOfFriends")
        container.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("DB url - ",description.url?.absoluteString)
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as? NSError
                fatalError(error!.localizedDescription)
            }
        }
    }
    
}

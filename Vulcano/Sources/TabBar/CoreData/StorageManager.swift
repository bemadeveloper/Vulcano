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
    
    let appDelegate = AppDelegate()
    var friends = [List]()
    
    public static let shared = StorageManager()
    private override init() { }
    
    // MARK: - funcs
    
    func fetchAllFriends() {
        let request: NSFetchRequest<List> = List.fetchRequest() as! NSFetchRequest<List>
        if let friends = try? appDelegate.persistentContainer.viewContext.fetch(request) {
            self.friends = friends
        }
    }
    
    // MARK: - 2
    
    func addNewFriend(name: String, dateOfBirth: String) {
        let friend = List(context: appDelegate.persistentContainer.viewContext)
        friend.id = UUID()
        friend.name = name
        friend.dateOfBirth = dateOfBirth
        appDelegate.saveContext()
        fetchAllFriends()
    }
}

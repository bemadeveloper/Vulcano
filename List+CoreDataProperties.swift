//
//  List+CoreDataProperties.swift
//  Vulcano
//
//  Created by Bema on 2/6/24.
//
//

import Foundation
import CoreData

@objc(List)
public class List: NSManagedObject { }

extension List {

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var dateOfBirth: String?
    @NSManaged public var old: String?

}

extension List: Identifiable { }

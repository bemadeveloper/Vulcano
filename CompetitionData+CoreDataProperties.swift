//
//  CompetitionData+CoreDataProperties.swift
//  Vulcano
//
//  Created by Bema on 4/6/24.
//
//

import Foundation
import CoreData

@objc(CompetitionData)
public class CompetitionData: NSManagedObject {

}

extension CompetitionData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompetitionData> {
        return NSFetchRequest<CompetitionData>(entityName: "CompetitionData")
    }

    @NSManaged public var dateOfCompetition: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var nameOfCompetition: String?
    @NSManaged public var winner: String?

}

extension CompetitionData : Identifiable {
    func updateCompetition(newName: String, newDate: Date, newWinner: String) {
        self.nameOfCompetition = newName
        self.dateOfCompetition = newDate
        self.winner = newWinner
        
        try? managedObjectContext?.save()
    }
    
    func deleteCompetition() {
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}

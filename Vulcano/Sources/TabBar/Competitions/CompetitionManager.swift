//
//  CompetitionManager.swift
//  Vulcano
//
//  Created by Bema on 4/6/24.
//

import Foundation
import UIKit
import CoreData


class CompetitionManager: NSObject {
    
    let appDelegate = AppDelegate()
    var competitions = [CompetitionData]()
    
    public static let shared = CompetitionManager()
    private override init() { }
    
    // MARK: - funcs
    
    func fetchAllCompetitions() {
        let request: NSFetchRequest<CompetitionData> = CompetitionData.fetchRequest()
        if let competitions = try? appDelegate.persistentContainer.viewContext.fetch(request) {
            self.competitions = competitions
        }
    }
    
    // MARK: - 2
    
    func addNewCompetition(nameOfCompetition: String, dateOfCompetition: Date, winner: String, listOfParticipants: String, time: String) {
        let competition = CompetitionData(context: appDelegate.persistentContainer.viewContext)
        competition.id = UUID()
        competition.nameOfCompetition = nameOfCompetition
        competition.dateOfCompetition = dateOfCompetition
        competition.winner = winner
        competition.listOfParticipants = listOfParticipants
        competition.time = time
        appDelegate.saveContext()
        fetchAllCompetitions()
    }
    
}

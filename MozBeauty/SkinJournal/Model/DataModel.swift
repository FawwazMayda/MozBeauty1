//
//  DataModel.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 24/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import CoreData

struct ViewModel {
    var productModel: ProductsUsed?
    var allJournalModel = [Journal]()
    var newJournalDayCount: Int = 0
    static let globalContext = ViewModel.getManagedContext()
    init() {
        //Add an empty Product
        productModel = ProductsUsed(context: ViewModel.globalContext)
        //Init an empty journal
        //allJournalModel.append(Journal(context: ViewModel.globalContext))
        print("Journal Count: \(allJournalModel.count)")
        //Fetch the core data Model
        loadSavedModel()
        allJournalModel.insert(Journal(context: ViewModel.globalContext), at: 0)
        print("Journal Count: \(allJournalModel.count)")
    }
    
    static func getManagedContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let container = appDelegate?.persistentContainer
        return container!.viewContext
    }
    
    mutating func loadSavedModel() {
        let request : NSFetchRequest<Journal> = Journal.fetchRequest()
        do {
            let res = try ViewModel.globalContext.fetch(request)
            print("Fetched data count: \(res.count)")
            res.forEach { (journal) in
                self.allJournalModel.append(journal)
            }
        } catch {
            return
        }
    }
}

extension Journal {
    func save() {
        do {
            try ViewModel.globalContext.save()
            print("Saving; \(self)")
        } catch {
            print(error)
        }
    }
}

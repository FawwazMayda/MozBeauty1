//
//  DataModel.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 24/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import CoreData

class ViewModel {
    var isProductCreated = false {
        didSet {
            if isProductCreated {
                loadJournal()
            }
        }
    }
    var currentDay : Int16 = 0
    var productModel: ProductsUsed?
    var allJournalModel = [Journal]()
    var newJournalDayCount: Int = 0
    static let globalContext = ViewModel.getManagedContext()
    
    init() {
        print("Init data model")
        loadProduct()
    }
    
    func reset() {
        //Set to the empty State
        productModel = nil
        allJournalModel = [Journal]()
        currentDay = 0
        isProductCreated = false
    }
    
    static func getManagedContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let container = appDelegate?.persistentContainer
        return container!.viewContext
    }
    
     func loadProduct() {
        // This is the entry point to load Product and Journal
        print("Loading Product")
        do {
            let req: NSFetchRequest<ProductsUsed> = ProductsUsed.fetchRequest()
            req.predicate = NSPredicate(format: "iscurrentproduct == true")
            let res = try ViewModel.globalContext.fetch(req)
            if res.isEmpty {
                // No product yet
                print("Creating Empty Product")
                productModel = ProductsUsed(context: ViewModel.globalContext)
                productModel?.id = UUID().uuidString
                productModel?.iscurrentproduct = true
            } else if (res.count == 1) {
                //Product already exists
                productModel = res[0]
                print("Fetched product: \(String(describing: productModel))")
                isProductCreated = true
            }
        } catch {
            print(error)
        }
    }
    
    func loadSavedJournal() {
        let request : NSFetchRequest<Journal> = Journal.fetchRequest()
        guard let idProduct = productModel?.id else {fatalError("No product ID")}
        request.predicate = NSPredicate(format: "id_product == %@", idProduct)
        // Sort so the last day is on top
        request.sortDescriptors = [NSSortDescriptor(key: "daycount", ascending: false)]
        
        do {
            let res = try ViewModel.globalContext.fetch(request)
            print("Fetched journal count: \(res.count)")
            if !res.isEmpty {
                res.forEach { (journal) in
                    if journal.daycount > self.currentDay {
                        self.currentDay = journal.daycount
                    }
                    self.allJournalModel.append(journal)
                }
            }
            self.currentDay += 1
            print("Current dayCount: \(self.currentDay)")
        } catch {
            return
        }
    }
    
     func loadJournal() {
            loadSavedJournal()
            if allJournalModel.isEmpty {
                allJournalModel.insert(Journal(context: ViewModel.globalContext), at: 0)
            } else {
                let today = Date()
                guard let savedDate = allJournalModel[0].datecreated else {fatalError("No Journal object date")}
                
                let formatter = DateFormatter()
                formatter.dateStyle = .full
                formatter.timeStyle = .none
                print("today string: \(formatter.string(from: today))")
                print("saved string: \(formatter.string(from: savedDate))")
                //Check whether today date is the same as the last journal created date
                if formatter.string(from: today) != formatter.string(from: savedDate) {
                    allJournalModel.insert(Journal(context: ViewModel.globalContext), at: 0)
                }
            }
    }
}

extension Journal {
    func save() -> Journal? {
        do {
            try ViewModel.globalContext.save()
            print("Saving; \(self)")
            return self
        } catch {
            print(error)
            return nil
        }
    }
}

extension ProductsUsed {
    func save() -> ProductsUsed? {
        do {
            try ViewModel.globalContext.save()
            print("Saving: \(self)")
            return self
        } catch {
            print(error)
            return nil
        }
    }
}

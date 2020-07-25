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
           loadJournal()
        }
    }
    var productModel: ProductsUsed?
    var allJournalModel = [Journal]()
    var newJournalDayCount: Int = 0
    static let globalContext = ViewModel.getManagedContext()
    
    init() {
        //Add an empty Product
        loadProduct()
        //productModel = ProductsUsed(context: ViewModel.globalContext)
        //Init an empty journal
        //allJournalModel.append(Journal(context: ViewModel.globalContext))
        //print("Journal Count: \(allJournalModel.count)")
        //Fetch the core data Model
        //loadSavedModel()
        //allJournalModel.insert(Journal(context: ViewModel.globalContext), at: 0)
        //print("Journal Count: \(allJournalModel.count)")
    }
    
    static func getManagedContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let container = appDelegate?.persistentContainer
        return container!.viewContext
    }
    
     func loadSavedJournal() {
        let request : NSFetchRequest<Journal> = Journal.fetchRequest()
        do {
            let res = try ViewModel.globalContext.fetch(request)
            print("Fetched journal count: \(res.count)")
            res.forEach { (journal) in
                self.allJournalModel.append(journal)
            }
        } catch {
            return
        }
    }
    
     func loadProduct() {
        let userDefault = UserDefaults.standard
        if userDefault.string(forKey: "currentUsedProduct")==nil {
            //Create one Product ID
            productModel = ProductsUsed(context: ViewModel.globalContext)
            productModel?.id = UUID().uuidString
        } else {
            //Fetch One ProductUsed
            let req : NSFetchRequest<ProductsUsed> = ProductsUsed.fetchRequest()
            req.predicate = NSPredicate(format: "id == %@", userDefault.string(forKey: "currentUsedProduct")!)
            
            do {
                let res = try ViewModel.globalContext.fetch(req)
                productModel = res.first
                print("Fetched product data: \(String(describing: productModel))")
                isProductCreated = true
            } catch {
                print(error)
            }
        }
    }
    
     func loadJournal() {
        if isProductCreated {
            loadSavedJournal()
            allJournalModel.insert(Journal(context: ViewModel.globalContext), at: 0)
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

extension ProductsUsed {
    func save() {
        do {
            try ViewModel.globalContext.save()
            print("Saving: \(self)")
        } catch {
            print(error)
        }
    }
}

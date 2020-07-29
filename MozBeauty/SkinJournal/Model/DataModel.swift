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
    var currentDay : Int16 = 0
    var productModel: ProductsUsed?
    var allJournalModel = [Journal]()
    var newJournalDayCount: Int = 0
    static let globalContext = ViewModel.getManagedContext()
    
    init() {
        print("Init data model")
        loadProduct()
    }
    
    static func getManagedContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let container = appDelegate?.persistentContainer
        return container!.viewContext
    }
    
     func loadSavedJournal() {
        let request : NSFetchRequest<Journal> = Journal.fetchRequest()
        request.predicate = NSPredicate(format: "id_product == %@", productModel?.id! as! CVarArg)
        request.sortDescriptors = [NSSortDescriptor(key: "daycount", ascending: false)]
        do {
            let res = try ViewModel.globalContext.fetch(request)
            print("Fetched journal count: \(res.count)")
            res.forEach { (journal) in
                self.allJournalModel.append(journal)
                if journal.daycount > self.currentDay {
                    self.currentDay = journal.daycount
                    print("Update dayCount: \(self.currentDay)")
                }
            }
            self.currentDay += 1
            print("Current dayCount: \(self.currentDay)")
        } catch {
            return
        }
    }
    
     func loadProduct() {
        print("Loading Product")
        let userDefault = UserDefaults.standard
        if userDefault.string(forKey: "currentUsedProduct")==nil {
            //Create one Product ID
            productModel = ProductsUsed(context: ViewModel.globalContext)
            productModel?.id = UUID().uuidString
            
            print("Creating empty Product")
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

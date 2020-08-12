//
//  DataModel.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 24/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import CoreData
import Combine

protocol ViewModelDelegate {
    func didNeedSync()
    func didNeedChartUpdate()
}

class ViewModel: ObservableObject {
    // Indicating whether product is already created
    var isProductCreated = false {
        didSet {
            if isProductCreated {
                //If product is created just load Journal
                loadJournal()
            } else {
                //If not created reset all to empty state
                // then load a product first
                reset()
                loadProduct()
            }
        }
    }
    
    var delegate: ViewModelDelegate?
    var currentDay : Int16 = 0
    var productModel: ProductsUsed?
    var allJournalModel = [Journal]()
    @Published var acneData = [Double]()
    @Published var wrinkleData = [Double]()
    var newJournalDayCount: Int = 0
    static let globalContext = ViewModel.getManagedContext()
    static let shared = ViewModel(withLoadingProduct: false)
    
    init(withLoadingProduct: Bool) {
        print("Init view model")
        //First init an product
        if withLoadingProduct {
            loadProduct()
        }
    }
    
    func reset() {
        //Set to the empty State
        print("Clearing Journal Data from View Model")
        productModel = nil
        allJournalModel = [Journal]()
        currentDay = 0
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
                    self.acneData.append(journal.acne)
                    self.wrinkleData.append(journal.foreheadwrinkle)
                }
            }
            self.currentDay += 1
            print("Current dayCount: \(self.currentDay)")
        } catch {
            return
        }
    }
    
    func createEmptyJournal() {
        if isProductCreated {
            if allJournalModel.isEmpty {
                      print("Journal is empty")
                      allJournalModel.insert(Journal(context: ViewModel.globalContext), at: 0)
            } else {
                      //If not empty add a new journal
                      //add only if the current day is not the same as the previous journal day
                      print("Exist: \(allJournalModel.count) already")
                      let today = Date()
                      guard let savedDate = allJournalModel[0].datecreated else {return}
                      
                      let formatter = DateFormatter()
                      formatter.dateStyle = .full
                      formatter.timeStyle = .none
                      print("today string: \(formatter.string(from: today))")
                      print("saved string: \(formatter.string(from: savedDate))")
                      
                      //Check whether today date is the same as the last journal created date
                      if formatter.string(from: today) != formatter.string(from: savedDate) {
                          //Making sure its greater than the previous ones
                          currentDay = allJournalModel[0].daycount + 1
                          allJournalModel.insert(Journal(context: ViewModel.globalContext), at: 0)
                      }
             }
        }
    }
    
     func loadJournal() {
            //First load a saved journal
            loadSavedJournal()
            // If empty just add a new one
            createEmptyJournal()
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

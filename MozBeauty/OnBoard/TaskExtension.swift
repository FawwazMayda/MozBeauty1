//
//  TaskExtension.swift
//  MozBeauty
//
//  Created by Lukius Jonathan on 22/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    func getViewContext() -> NSManagedObjectContext? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let container = appDelegate?.persistentContainer
        return container?.viewContext
    }
}

//Task is coming from Entity Task
extension User {
    
    static func fetchAll(viewContext: NSManagedObjectContext)-> [User] {
        let request : NSFetchRequest<User> = User.fetchRequest()
        guard let res = try? viewContext.fetch(request) else { fatalError("Not Res") }
        return res
    }
    
    static func save(viewContext : NSManagedObjectContext, nama : String) -> User? {
        let newTask = User(context: viewContext)
        newTask.nama = nama
        do {
            try viewContext.save()
            return newTask
        } catch {
            return nil
        }
    }
    
    static func deleteAll(viewContext : NSManagedObjectContext) {
        let tasks = fetchAll(viewContext: viewContext)
        for task in tasks {
            self.delete(viewContext: viewContext, taskToBeDeleted: task)
        }
    }
    
    static func delete(viewContext : NSManagedObjectContext, taskToBeDeleted : User) {
         print("\(String(describing: taskToBeDeleted.nama)) is deleted")
        viewContext.delete(taskToBeDeleted)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting")
        }
    }
    
}

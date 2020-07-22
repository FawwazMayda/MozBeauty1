//
//  CoreDataHelper.swift
//  MozBeauty
//
//  Created by Lukius Jonathan on 22/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataHelper {
    var viewContext : NSManagedObjectContext
    func fetchAll<T:NSManagedObject> () -> [T] {
        let request : NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        guard let res = try? viewContext.fetch(request) else { fatalError("Not Res") }
        return res
    }
    
}

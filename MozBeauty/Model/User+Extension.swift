//
//  User+Extension.swift
//  MozBeauty
//
//  Created by Feby Lailani on 24/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation
import CoreData

extension User {
    static func getUserData(viewContext: NSManagedObjectContext) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let results = try viewContext.fetch(request)
            if results.count > 0 {
                return results[0]
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    static func saveUserData(viewContext: NSManagedObjectContext, userData: UserData) -> User? {
        do {
            // code to save the datas
            let user = User(context: viewContext)
            user.nama = userData.nama
            user.allergy = userData.allergy
            user.gender = userData.gender
            user.id = ""
            user.skintype = userData.skintype
            user.ttl = userData.ttl
            
           print(user)
            
            // confirm save datas to core data
            try viewContext.save()
            return user
        } catch {
            print("ERROR SAVE PROFILE")
            return nil
        }
    }
}

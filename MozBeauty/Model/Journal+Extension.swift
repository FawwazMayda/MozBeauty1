//
//  Journal+Extension.swift
//  MozBeauty
//
//  Created by Feby Lailani on 24/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation
import CoreData

extension Journal {
    static func getJournalData(viewContext: NSManagedObjectContext) -> Journal? {
        let request: NSFetchRequest<Journal> = Journal.fetchRequest()
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
    
    static func saveJournalData(viewContext: NSManagedObjectContext, journalData: JournalData) -> Journal? {
        do {
            // code to save the datas
            let journal = Journal(context: viewContext)
            journal.acne = journalData.acne
            journal.blackhead = journalData.blackhead
            journal.daycount = journalData.daycount
            jou
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

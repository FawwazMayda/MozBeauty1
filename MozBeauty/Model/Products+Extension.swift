//
//  Products+Extension.swift
//  MozBeauty
//
//  Created by Feby Lailani on 25/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation
import CoreData

extension ProductsUsed {
    static func getProductsData(viewContext: NSManagedObjectContext) -> ProductsUsed? {
        let request: NSFetchRequest<ProductsUsed> = ProductsUsed.fetchRequest()
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
    
    static func saveProductsData(viewContext: NSManagedObjectContext, productsData: ProductsUsed) -> ProductsUsed? {
        do {
            // code to save the datas
            let productsUsed = ProductsUsed(context: viewContext)
            productsUsed.durasi = productsData.durasi
            productsUsed.foto = productsData.foto
            productsUsed.id = productsData.id
            productsUsed.kategori = productsData.kategori
            productsUsed.namaproduk = productsData.namaproduk
            
           print(productsUsed)
            
            // confirm save datas to core data
            try viewContext.save()
            return productsUsed
        } catch {
            print("ERROR SAVE PRODUCTS")
            return nil
        }
    }
}

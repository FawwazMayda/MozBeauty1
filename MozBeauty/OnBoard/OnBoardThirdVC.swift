//
//  OnBoardThirdVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import CoreData

class OnBoardThirdVC: UIViewController {

    @IBOutlet weak var inputNameTextField: UITextField!
    @IBOutlet weak var inputSkinTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

//    @IBAction func saveBtn(_ sender: Any) {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
//        let newEntity=NSManagedObject(entity: entity!, insertInto: context)
//
//        newEntity.setValue(inputNameTextField.text, forKey: "nama")
//
//        do{
//            try context.save()
//            print("saved")
//        }catch{
//            print("failed")
//        }
//    }
//    func getData(){
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        request.returnsObjectsAsFaults = false
//
//    do{
//         let result = try context.fetch(request)
//          for data in result as! [ NSManagedObject]
//         {
//         }
//        }
//    }
  

}

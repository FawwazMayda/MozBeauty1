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
    
    
    @IBOutlet weak var maleState: UIButton!
    @IBOutlet weak var femaleState: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maleState.backgroundColor = .clear
        maleState.layer.cornerRadius = 10
        maleState.layer.borderWidth = 1
        maleState.layer.borderColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        femaleState.backgroundColor = .clear
              femaleState.layer.cornerRadius = 10
              femaleState.layer.borderWidth = 1
              femaleState.layer.borderColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
    }
    

    @IBAction func maleBtn(_ sender: Any) {
        maleState.layer.backgroundColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        maleState.setTitleColor(UIColor(red: 253/255, green: 251/255, blue: 251/255, alpha: 1.0), for: UIControl.State.normal)
        femaleState.backgroundColor = .clear
        
    }
    @IBAction func femaleBtn(_ sender: Any) {
        femaleState.layer.backgroundColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        femaleState.setTitleColor(UIColor(red: 253/255, green: 251/255, blue: 251/255, alpha: 1.0), for: UIControl.State.normal)
        maleState.backgroundColor = .clear
    }
    @IBAction func saveBtn(_ sender: Any) {
     
       
    }
//    func saveDetail(User: String) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
//        let context = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
//        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
//        manageObject.setValue(User, forKey: "User")
//        do {
//            try context.save()
//        } catch {
//          
//        }
//    }
  

}

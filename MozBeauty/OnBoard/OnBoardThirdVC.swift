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
    @IBOutlet weak var yearPickerView: UIDatePicker!
    
    
    @IBOutlet weak var maleState: UIButton!
    @IBOutlet weak var femaleState: UIButton!
    
    //CoreData User
    var userModel = User(context: ViewModel.globalContext)
    var nama = ""
    var skin = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        maleState.backgroundColor = .clear
        maleState.layer.cornerRadius = 10
        maleState.layer.borderWidth = 1
        maleState.layer.borderColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        femaleState.backgroundColor = .clear
        femaleState.layer.cornerRadius = 10
        femaleState.layer.borderWidth = 1
        femaleState.layer.borderColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
    }
    @objc func dismissKeyboard() {
           //Causes the view (or one of its embedded text fields) to resign the first responder status.
           view.endEditing(true)
       }
    
    @IBAction func namaField(_ sender: UITextField) {
        print(sender.text!)
        nama = sender.text!
    }
    @IBAction func skinField(_ sender: UITextField) {
        print(sender.text!)
        skin = sender.text!
    }
    

    private func alertMinimalCharaNotExceed() {
          let alert = UIAlertController(title: "Please input your data", message: "Please complete all the collumn", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
          self.present(alert, animated: true)
      }
    @IBAction func maleBtn(_ sender: Any) {
        maleState.layer.backgroundColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        maleState.setTitleColor(UIColor(red: 253/255, green: 251/255, blue: 251/255, alpha: 1.0), for: UIControl.State.normal)
        
        femaleState.backgroundColor = .clear
        femaleState.setTitleColor(UIColor(red: 131/255, green: 66/255, blue: 87/255, alpha: 1.0), for: UIControl.State.normal)
    }
    @IBAction func femaleBtn(_ sender: Any) {
        femaleState.layer.backgroundColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        femaleState.setTitleColor(UIColor(red: 253/255, green: 251/255, blue: 251/255, alpha: 1.0), for: UIControl.State.normal)
        maleState.backgroundColor = .clear
        maleState.setTitleColor(UIColor(red: 131/255, green: 66/255, blue: 87/255, alpha: 1.0), for: UIControl.State.normal)
    }

    @IBAction func saveBtn(_ sender: UIButton) {
        nama = inputNameTextField.text!
        skin = inputSkinTextField.text!
        
                     
        if (inputNameTextField.text == "" || inputSkinTextField.text == "" ) {
            createAlert(message: "Please fill all the form")}
        else{
            userModel.nama = inputNameTextField.text
               userModel.allergy = inputSkinTextField.text
               if sender.tag==1{
                   userModel.gender = "Male"
               }
               else if sender.tag==2{
                   userModel.gender="Female"
               }
               userModel.save() // Save to coreData
//            self.nextPage()
            performSegue(withIdentifier: "SkinType", sender: self)
        }

   
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SkinType") {
            _ = segue.destination as! OnBoardFourthVC
        }
    }
    func createAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    func nextPage(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInVC = storyboard.instantiateViewController(withIdentifier: "OnBoardFourthVC")
        loggedInVC.modalPresentationStyle = .fullScreen
        self.present(loggedInVC, animated: true, completion: nil)
    }
    
    func loadExample() {
        let req : NSFetchRequest<User> = User.fetchRequest()
        do {
            let res = try ViewModel.globalContext.fetch(req)
            let firstItem = res[0]
            //firstItem.allergy
            //firstItem.nama
            
        } catch {
            print(error)
        }
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
extension User{
    func save() {
        do {
            try ViewModel.globalContext.save()
            print("Saving: \(self)")
        } catch {
            print(error)
        }
    }
}

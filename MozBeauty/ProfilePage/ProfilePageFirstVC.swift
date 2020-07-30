//
//  ProfilePageFirstVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import CoreData

class ProfilePageFirstVC: UIViewController {
    
    @IBOutlet weak var allergiesTextField: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var genderTextField: UILabel!
    
    var userModel : User?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadExample()
        nameTextField.text=userModel?.nama
        genderTextField.text=userModel?.gender
        allergiesTextField.text=userModel?.allergy
        if let currentImage = userModel?.fotoprofil{
            imgProfile.image = UIImage.init(data: currentImage)
        }
        setImgandBtn()
        // Do any additional setup after loading the view.
    }
    
      func setImgandBtn() {
           imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
            imgProfile.clipsToBounds=true
            imgProfile.layer.shadowRadius=10
            imgProfile.layer.shadowColor=UIColor.black.cgColor
            imgProfile.layer.shadowOffset=CGSize.zero
            imgProfile.layer.shadowOpacity=1
            imgProfile.layer.shadowPath = UIBezierPath(rect: imgProfile.bounds).cgPath
    }
    
    func loadExample() {
        let req : NSFetchRequest<User> = User.fetchRequest()
        do {
            let res = try ViewModel.globalContext.fetch(req)
            userModel = res.last
            //firstItem.allergy
            //firstItem.nama
            
        } catch {
            print(error)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  OnBoardFifthVC.swift
//  MozBeauty
//
//  Created by Lukius Jonathan on 23/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import CoreData

class OnBoardFifthVC: UIViewController {
    
    
    @IBOutlet weak var circleEmpty: UIImageView!
    
    let pertanyaan=["Skin Apperance","Pores","Acne","Skin Feel"]
    let pertanyaanSkinAppearance=["Smooth Texture","Greasy Appearance","Flaky and rough skin","Oily T-zone and dry cheeks","Have a reaction to specific environtment ( example : during hot weather skin becomes red and itchy)"]
    let pertanyaanPores = ["Fine pores","Open/Big pores","No Blemishes"]
    let pertanyaanAcne=["Few or no break outs","Prone to breakouts","Breakouts only on forehead, chin and nose"]
    let pertanyaanSkinFeel=["Itching","Skin feels tight","Skin feels itchy and tight","Feels itchy while wearing tight clothes"]
    
    var userModel : User?
    var score = 0
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var btn4: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      loadExample()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        if sender.tag == 1{
            btn1.isSelected = true
            userModel?.hitungscore = "Normal"
            userModel?.save()
        }
        if sender.tag == 2{
            btn2.isSelected = true
            userModel?.hitungscore = "Oily"
            userModel?.save()
           
               }
        if sender.tag == 3{
            btn3.isSelected = true
            userModel?.hitungscore="Dry"
            userModel?.save()
               }
        if sender.tag == 4{
            btn4.isSelected = true
            userModel?.hitungscore="Comnbination"
            userModel?.save()
               }
        if sender.tag == 5{
            btn5.isSelected = true
            userModel?.hitungscore="Sensitive"
            userModel?.save()
        }
        userModel?.save()
        
    }
    func loadExample() {
        let req : NSFetchRequest<User> = User.fetchRequest()
        do {
            let res = try ViewModel.globalContext.fetch(req)
            userModel = res.last
         
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



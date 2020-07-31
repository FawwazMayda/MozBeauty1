//
//  HomePageFirstVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import CoreData

class HomePageFirstVC: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var viewSkinCond: UIView!
    @IBOutlet weak var fotoSkin: UIImageView!
    
    @IBOutlet weak var skinLabel: UILabel!
    var userModel: User?
    var userModel2: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareScreen()
        loadExampleSkin()
        loadExample()
        
        if userModel!.hitungscore=="Normal" || userModel2!.hitungscore=="Normal"{
            fotoSkin.image=#imageLiteral(resourceName: "Homepage-normal")
            skinLabel.text="Normal Skin"

        }
        else if userModel!.hitungscore=="Oily" || userModel2!.hitungscore=="Oily"{
            fotoSkin.image=#imageLiteral(resourceName: "Homepage-oily")
            skinLabel.text="Oily Skin"
        }
        else if userModel!.hitungscore=="Dry" || userModel2!.hitungscore=="Dry"{
            fotoSkin.image=#imageLiteral(resourceName: "Homepage-dry")
            skinLabel.text="Dry Skin"

            
        }
        else if userModel!.hitungscore=="Combination" || userModel2!.hitungscore=="Combination"{
            fotoSkin.image=#imageLiteral(resourceName: "Hompage-combi")
            skinLabel.text="Combination Skin"

        }
        else if userModel!.hitungscore=="Sensitive" || userModel2!.hitungscore=="Sensitive"{
            fotoSkin.image=#imageLiteral(resourceName: "Homepage-sensitive")
            skinLabel.text="Sensitive skin"

        }
        // Do any additional setup after loading the view.
        
//        var userData = User.getUserData(viewContext: getViewContext())
//        print(userData)
//        if (userData == nil) {
//            userData = User.saveUserData(viewContext: getViewContext(), userData: UserData(nama: "Feby", ttl: Date(), gender: "F", id: "1", skintype: "oily", allergy: "no"))
//
//            if (userData == nil) {
//                print("SAVE USER GAGAL")
//            } else {
//                print("SAVE USER SUCCESS")
//            }
//        }
    }
    func loadExample() {
              let req : NSFetchRequest<User> = User.fetchRequest()
              do {
                  let res = try ViewModel.globalContext.fetch(req)
               userModel = res[0]
                  //firstItem.allergy
                  //firstItem.nama
                  
              } catch {
                  print(error)
              }
          }
       func loadExampleSkin() {
                  let req : NSFetchRequest<User> = User.fetchRequest()
                  do {
                      let res = try ViewModel.globalContext.fetch(req)
                   userModel2 = res.last
                      
                      //firstItem.allergy
                      //firstItem.nama
                      
                  } catch {
                      print(error)
                  }
              }
    
    func prepareScreen()  {
        //date label
       
        
//        print(Date())
        
        
        //UIView
        viewSkinCond.layer.cornerRadius = 20
        viewSkinCond.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        //name label
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func onPressedProfileButton(_ sender: UIButton) {
        print("PROFILE")
    }
    
    @IBAction func onPressSkinType(_ sender: UITapGestureRecognizer) {
        print("PRESS SKIN TYPE")
    }
    @IBAction func onPressedSkinJournal(_ sender: UITapGestureRecognizer) {
        print("PRESS SKIN JOURNAL")
    }
    @IBAction func onPressedViewAllJournal(_ sender: UIButton) {
        print("VIEW ALL")
    }
    
    
    @IBAction func onPressedProgress(_ sender: UITapGestureRecognizer) {
        print("PRESS YOUR PROGRESS")
    }
    
    @IBAction func onPressedHistoryProducts(_ sender: UITapGestureRecognizer) {
        print("PRESS HISTORY PRODUCTS")
    }
    
    
}

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
    @IBOutlet weak var journalImageView: UIImageView!
    @IBOutlet weak var journalHeadLabel: UILabel!
    @IBOutlet weak var journalDescLabel: UILabel!
    var userModel: User?
    var userModel2: User?
    let journalViewModel = ViewModel.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalViewModel.loadProduct()
        journalViewModel.delegate = self
        print("Homepage did load")
        loadExampleSkin()
        loadExample()
        setTodayLabel()
        
        nameLabel.text=userModel2?.nama
        
        
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
    
    func setTodayLabel() {
         let formatter = DateFormatter()
         formatter.timeStyle = .none
         formatter.dateStyle = .full
         dateLabel.text = formatter.string(from: Date())
     }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           print("Homepage will appear")
           prepareForJournal()
           self.navigationController?.setNavigationBarHidden(true, animated: animated)
       }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Homepage did appear")
    }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    @IBAction func onPressedProfileButton(_ sender: UIButton) {
        print("PROFILE")
    }
    
    @IBAction func onPressSkinType(_ sender: UITapGestureRecognizer) {
        print("PRESS SKIN TYPE")
    }
    @IBAction func onPressedSkinJournal(_ sender: UITapGestureRecognizer) {
        print("PRESS SKIN JOURNAL")
        //Reference to Storyboard
        let sb = UIStoryboard(name: "SkinJournalSB", bundle: nil)
        
        if journalViewModel.isProductCreated {
            //Product already created so
            guard let destVC = sb.instantiateViewController(identifier: "AddJournal") as? SkinJournalThird else {fatalError("Error init VC Journal")}
            destVC.viewModel = journalViewModel
            destVC.index = 0
            //If photo is exist then its editing
            //If dont exist is the otherwise
            if let _ = journalViewModel.allJournalModel[0].photo {
                destVC.isEditingJournal = true
            } else {
                destVC.isEditingJournal = false
            }
            self.navigationController?.pushViewController(destVC, animated: true)
            
        } else {
            //Product haven't created
            guard let destVC = sb.instantiateViewController(identifier: "AddProduct") as? SkinJournalSecondVC else {fatalError("Error init VC Product")}
            destVC.viewModel = journalViewModel
            self.navigationController?.pushViewController(destVC, animated: true)
        }
        
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
    
    //MARK: - HomePage Journal
    
    func prepareForJournal() {
        //Prepare Journal
        journalViewModel.createEmptyJournal()
        //When the product is created
        if journalViewModel.isProductCreated {
            let currentJournal = journalViewModel.allJournalModel[0]
            //Journal maybe filled
            if let img = currentJournal.photo {
                let durasi = journalViewModel.productModel!.durasi
                journalHeadLabel.text = "Day \(currentJournal.daycount)/ \(durasi)"
                
                journalImageView.image = UIImage(data: img)
                let acneScore = currentJournal.acne
                let wrinkleScore = currentJournal.foreheadwrinkle
                journalDescLabel.text = "Acne: \(String(format: "%.2f", acneScore)) Wrinkle: \(String(format: "%.2f", wrinkleScore))"
            } else {
                //Journal maybe empty
                journalHeadLabel.text = "Add a New Journal"
                journalDescLabel.text = "You Haven't created journal today"
                journalImageView.image = UIImage (named: "Home page")
            }
        } else {
            journalHeadLabel.text = "Add a New Product"
            journalDescLabel.text = "You Haven't start monitoring yet"
            journalImageView.image = UIImage (named: "Home page")
        }
    }
    
}

extension HomePageFirstVC: ViewModelDelegate {
    func didNeedSync() {
        self.prepareForJournal()
    }
}

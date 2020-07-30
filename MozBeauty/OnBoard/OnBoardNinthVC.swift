//
//  OnBoardNinthVC.swift
//  MozBeauty
//
//  Created by Lukius Jonathan on 29/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import CoreData

class OnBoardNinthVC: UIViewController {

    @IBOutlet weak var foto: UIImageView!
    
    @IBOutlet weak var labelPenjelasan: UILabel!
    var userModel : User?
    var userModel2 : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadExample()
        loadExampleSkin()
        if userModel!.hitungscore=="Normal"{
            foto.image=#imageLiteral(resourceName: "normal skin result")
            labelPenjelasan.text="Normal skin is characterized by having a smooth texture, fines pores, and no blemishes. it is neither too oily or too dry. Normal skin tends to have balanced pH levels and sebum production"
        }
        else if userModel!.hitungscore=="Oily"{
            foto.image=#imageLiteral(resourceName: "Oily Skin Result")
        }
        else if userModel!.hitungscore=="Dry"{
            foto.image=#imageLiteral(resourceName: "Dry skin result")
            labelPenjelasan.text="Dry skin is characterized by having an uneven texture, itching, and skin feels tight. A lack of moisture in the skin can result in flaky and rough appearance"
            
        }
        else if userModel!.hitungscore=="Combination"{
            foto.image=#imageLiteral(resourceName: "Combination Skin result")
            labelPenjelasan.text="Combination skin is a mixture of two skin types , dry skin and oily skin. Combination skin is characterized by having an oily t-zone and dry cheeks, and also sensitive cheeks. You may see a change in your skin type depending on the change in the climate."
        }
        else if userModel!.hitungscore=="Sensitive"{
            foto.image=#imageLiteral(resourceName: "Sensitive skin result")
            labelPenjelasan.text="Sensitive skin is characterized by having an itchy and tight skin and it becomes red after a hot water bath. An excessive exposire to skin-damaging environmental factors such as excessive heat or cold might be the cause of a sensitive skin"
        }
        userModel2?.save()
        // Do any additional setup after loading the view.
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
    @IBAction func keHome(_ sender: Any) {
        self.goToHome()
    }
    func goToHome(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInVC = storyboard.instantiateViewController(withIdentifier: "HomePageFirstVC")
        loggedInVC.modalPresentationStyle = .fullScreen
        self.present(loggedInVC, animated: true, completion: nil)
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

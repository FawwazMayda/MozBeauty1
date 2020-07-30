//
//  OnBoardSixthVC.swift
//  MozBeauty
//
//  Created by Lukius Jonathan on 29/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import CoreData
class OnBoardSixthVC: UIViewController {

    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn1: UIButton!
    var userModel : User?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadExample()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var btn2: UIButton!
 

    @IBAction func nextButton(_ sender: UIButton) {
       
        
    }
    @IBAction func pilihBtn(_ sender: UIButton) {
        if sender.tag == 1  {
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
                userModel?.hitungscore = "Normal"
                userModel?.save()
                      }
        if sender.tag==1 && sender.tag==3 {
            userModel?.hitungscore = "Normal"
            userModel?.save()
        }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

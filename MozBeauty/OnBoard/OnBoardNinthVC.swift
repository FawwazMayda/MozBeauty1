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
    var userModel = User(context: ViewModel.globalContext)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userModel.hitungscore=="Normal"{
            foto.image=#imageLiteral(resourceName: "normal skin result")
        }
        if userModel.hitungscore=="Oily"{
            foto.image=#imageLiteral(resourceName: "Oily Skin Result")
        }
        if userModel.hitungscore=="Dry"{
            foto.image=#imageLiteral(resourceName: "Dry skin result")
        }
        if userModel.hitungscore=="Combination"{
            foto.image=#imageLiteral(resourceName: "Combination Skin result")
        }
        if userModel.hitungscore=="Sensitive"{
            foto.image=#imageLiteral(resourceName: "Sensitive skin result")
        }
        
        // Do any additional setup after loading the view.
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

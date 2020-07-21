//
//  OnBoardFourthVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class OnBoardFourthVC: UIViewController {

    @IBOutlet weak var notSureBtn: UIButton!
    @IBOutlet weak var normalSkinBtn: UIButton!
    @IBOutlet weak var drySkinBtn: UIButton!
    @IBOutlet weak var sensitiveSkinBtn: UIButton!
    @IBOutlet weak var oilySkinBtn: UIButton!
    @IBOutlet weak var combinationSkinBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        normalSkinBtn.backgroundColor = .clear
        normalSkinBtn.layer.cornerRadius = 10
        normalSkinBtn.layer.borderWidth = 1
        normalSkinBtn.layer.borderColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor

        
        drySkinBtn.backgroundColor = .clear
        drySkinBtn.layer.cornerRadius = 10
        drySkinBtn.layer.borderWidth = 1
        drySkinBtn.layer.borderColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        
        sensitiveSkinBtn.backgroundColor = .clear
        sensitiveSkinBtn.layer.cornerRadius = 10
        sensitiveSkinBtn.layer.borderWidth = 1
        sensitiveSkinBtn.layer.borderColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        
        oilySkinBtn.backgroundColor = .clear
        oilySkinBtn.layer.cornerRadius = 10
        oilySkinBtn.layer.borderWidth = 1
        oilySkinBtn.layer.borderColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        
        combinationSkinBtn.backgroundColor = .clear
        combinationSkinBtn.layer.cornerRadius = 10
        combinationSkinBtn.layer.borderWidth = 1
        combinationSkinBtn.layer.borderColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        
        notSureBtn.backgroundColor = .clear
        notSureBtn.layer.cornerRadius = 10
        notSureBtn.layer.borderWidth = 1
        notSureBtn.layer.borderColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        // Do any additional setup after loading the view.
    }
    @IBAction func normalSkinTouched(_ sender: Any) {
        normalSkinBtn.layer.backgroundColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        goToHomePage()
    }
    
    func goToHomePage() {
        guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitHomeViewController") as? UINavigationController else {
            return
        }
        let navigationController = rootVC

        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
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



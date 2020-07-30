//
//  OnBoardFourthVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class OnBoardFourthVC: UIViewController {

    @IBOutlet weak var combinationText: UILabel!
    @IBOutlet weak var oilyText: UILabel!
    @IBOutlet weak var notSureBtn: UIButton!
    @IBOutlet weak var normalSkinBtn: UIButton!
    @IBOutlet weak var drySkinBtn: UIButton!
    @IBOutlet weak var sensitiveSkinBtn: UIButton!
    @IBOutlet weak var oilySkinBtn: UIButton!
    @IBOutlet weak var combinationSkinBtn: UIButton!
    @IBOutlet weak var normalText: UILabel!
    @IBOutlet weak var dryText: UILabel!
    @IBOutlet weak var sensitiveText: UILabel!
    @IBOutlet weak var notSureText: UILabel!
    @IBOutlet weak var submitButtonClicked: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        posisiAwal()
        
        
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
    }
    func posisiAwal(){
        normalSkinBtn.frame.origin.y = 159
        drySkinBtn.frame.origin.y = 221
        sensitiveSkinBtn.frame.origin.y = 284
        oilySkinBtn.frame.origin.y = 347
        combinationSkinBtn.frame.origin.y = 415
        notSureBtn.frame.origin.y = 480
        normalText.frame.origin.y = 209
        dryText.frame.origin.y = 271
        sensitiveText.frame.origin.y=314
        oilyText.frame.origin.y = 397
        combinationText.frame.origin.y = 460
        notSureText.frame.origin.y = 500
    }
    func playNormal(){
        normalText.isHidden = false
        dryText.isHidden = true
        oilyText.isHidden=true
        combinationText.isHidden=true
        notSureText.isHidden=true

            UIView.animate(withDuration: 0.8, animations: {
                self.drySkinBtn.frame.origin.y = 281
            },completion: nil)
            UIView.animate(withDuration: 0.8, animations: {
                       self.oilySkinBtn.frame.origin.y = 407
                   },completion: nil)
            UIView.animate(withDuration: 0.8, animations: {
                       self.combinationSkinBtn.frame.origin.y = 470
                   },completion: nil)
            UIView.animate(withDuration: 0.8, animations: {
                       self.notSureBtn.frame.origin.y = 533
                   },completion: nil)
            UIView.animate(withDuration: 0.8, animations: {
                self.sensitiveSkinBtn.frame.origin.y = 344
            },completion: nil)
    
    }
        func playDry(){
            dryText.isHidden = false
            normalText.isHidden = true
            sensitiveText.isHidden=true
            oilyText.isHidden=true
            combinationText.isHidden=true
            notSureText.isHidden=true

           UIView.animate(withDuration: 0.0, animations: {
                self.dryText.frame.origin.y = 271
            },completion: nil)
               UIView.animate(withDuration: 0.5, animations: {
                   self.drySkinBtn.frame.origin.y = 221
               },completion: nil)
                 UIView.animate(withDuration: 0.8, animations: {
                                      self.oilySkinBtn.frame.origin.y = 407
                                  },completion: nil)
                           UIView.animate(withDuration: 0.8, animations: {
                                      self.combinationSkinBtn.frame.origin.y = 470
                                  },completion: nil)
                           UIView.animate(withDuration: 0.8, animations: {
                                      self.notSureBtn.frame.origin.y = 533
                                  },completion: nil)
                           UIView.animate(withDuration: 0.8, animations: {
                               self.sensitiveSkinBtn.frame.origin.y = 344
                           },completion: nil)
            }
    func playSensitive(){
        dryText.isHidden = true
         normalText.isHidden = true
        sensitiveText.isHidden = false
        oilyText.isHidden=true
        combinationText.isHidden=true
        notSureText.isHidden=true

        UIView.animate(withDuration: 0.0, animations: {
             self.sensitiveText.frame.origin.y = 314
         },completion: nil)
            UIView.animate(withDuration: 0.8, animations: {
                self.drySkinBtn.frame.origin.y = 221
            },completion: nil)
              UIView.animate(withDuration: 0.8, animations: {
                                   self.oilySkinBtn.frame.origin.y = 407
                               },completion: nil)
                        UIView.animate(withDuration: 0.8, animations: {
                                   self.combinationSkinBtn.frame.origin.y = 470
                               },completion: nil)
                        UIView.animate(withDuration: 0.8, animations: {
                                   self.notSureBtn.frame.origin.y = 533
                               },completion: nil)
                        UIView.animate(withDuration: 0.5, animations: {
                            self.sensitiveSkinBtn.frame.origin.y = 284
                        },completion: nil)
    }
    func playOily(){
        dryText.isHidden = true
         normalText.isHidden = true
        sensitiveText.isHidden = true
        oilyText.isHidden=false
        combinationText.isHidden=true
        notSureText.isHidden=true

        UIView.animate(withDuration: 0.0, animations: {
             self.oilyText.frame.origin.y = 397
         },completion: nil)
            UIView.animate(withDuration: 0.8, animations: {
                self.drySkinBtn.frame.origin.y = 221
            },completion: nil)
              UIView.animate(withDuration: 0.8, animations: {
                                   self.oilySkinBtn.frame.origin.y = 347
                               },completion: nil)
                        UIView.animate(withDuration: 0.8, animations: {
                                   self.combinationSkinBtn.frame.origin.y = 470
                               },completion: nil)
                        UIView.animate(withDuration: 0.8, animations: {
                                   self.notSureBtn.frame.origin.y = 533
                               },completion: nil)
                        UIView.animate(withDuration: 0.5, animations: {
                            self.sensitiveSkinBtn.frame.origin.y = 284
                        },completion: nil)
    }
    func playCombination(){
        dryText.isHidden = true
         normalText.isHidden = true
        sensitiveText.isHidden = true
        oilyText.isHidden=true
        combinationText.isHidden=false
        notSureText.isHidden=true

        UIView.animate(withDuration: 0.0, animations: {
             self.combinationText.frame.origin.y = 455
         },completion: nil)
            UIView.animate(withDuration: 0.8, animations: {
                self.drySkinBtn.frame.origin.y = 221
            },completion: nil)
              UIView.animate(withDuration: 0.8, animations: {
                                   self.oilySkinBtn.frame.origin.y = 347
                               },completion: nil)
                        UIView.animate(withDuration: 0.8, animations: {
                                   self.combinationSkinBtn.frame.origin.y = 415
                               },completion: nil)
                        UIView.animate(withDuration: 0.8, animations: {
                                   self.notSureBtn.frame.origin.y = 533
                               },completion: nil)
                        UIView.animate(withDuration: 0.5, animations: {
                            self.sensitiveSkinBtn.frame.origin.y = 284
                        },completion: nil)
    }
    
    func playNotSure(){
        dryText.isHidden = true
         normalText.isHidden = true
        sensitiveText.isHidden = true
        oilyText.isHidden=true
        combinationText.isHidden=true
        notSureText.isHidden=false
        UIView.animate(withDuration: 0.0, animations: {
             self.notSureText.frame.origin.y = 505
         },completion: nil)
            UIView.animate(withDuration: 0.8, animations: {
                self.drySkinBtn.frame.origin.y = 221
            },completion: nil)
              UIView.animate(withDuration: 0.8, animations: {
                                   self.oilySkinBtn.frame.origin.y = 347
                               },completion: nil)
                        UIView.animate(withDuration: 0.8, animations: {
                                   self.combinationSkinBtn.frame.origin.y = 415
                               },completion: nil)
                        UIView.animate(withDuration: 0.8, animations: {
                                   self.notSureBtn.frame.origin.y = 480
                               },completion: nil)
                        UIView.animate(withDuration: 0.5, animations: {
                            self.sensitiveSkinBtn.frame.origin.y = 284
                        },completion: nil)
    }
    
    @IBAction func normalSkinTouched(_ sender: Any) {
        playNormal()
        normalSkinBtn.layer.backgroundColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
         normalSkinBtn.setTitleColor(UIColor(red: 253/255, green: 251/255, blue: 251/255, alpha: 1.0), for: UIControl.State.normal)
        notSureBtn.backgroundColor = .clear
        drySkinBtn.backgroundColor = .clear
        sensitiveSkinBtn.backgroundColor = .clear
        oilySkinBtn.backgroundColor = .clear
        combinationSkinBtn.backgroundColor = .clear
        notSureBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        drySkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        sensitiveSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        oilySkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        combinationSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)

    }
    
    @IBAction func drySkinTouched(_ sender: Any) {
        playDry()
        drySkinBtn.layer.backgroundColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
         drySkinBtn.setTitleColor(UIColor(red: 253/255, green: 251/255, blue: 251/255, alpha: 1.0), for: UIControl.State.normal)
        notSureBtn.backgroundColor = .clear
               normalSkinBtn.backgroundColor = .clear
               sensitiveSkinBtn.backgroundColor = .clear
               oilySkinBtn.backgroundColor = .clear
               combinationSkinBtn.backgroundColor = .clear
        normalSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        notSureBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        sensitiveSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        oilySkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        combinationSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
    }
    @IBAction func sensitiveSkinTouched(_ sender: Any) {
        playSensitive()
        sensitiveSkinBtn.layer.backgroundColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
         sensitiveSkinBtn.setTitleColor(UIColor(red: 253/255, green: 251/255, blue: 251/255, alpha: 1.0), for: UIControl.State.normal)
        notSureBtn.backgroundColor = .clear
        normalSkinBtn.backgroundColor = .clear
        drySkinBtn.backgroundColor = .clear
        oilySkinBtn.backgroundColor = .clear
        combinationSkinBtn.backgroundColor = .clear
        normalSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        drySkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        notSureBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        oilySkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        combinationSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
    }
    @IBAction func oliySkinTouched(_ sender: Any) {
        playOily()
        oilySkinBtn.layer.backgroundColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
         oilySkinBtn.setTitleColor(UIColor(red: 253/255, green: 251/255, blue: 251/255, alpha: 1.0), for: UIControl.State.normal)
        notSureBtn.backgroundColor = .clear
        normalSkinBtn.backgroundColor = .clear
        sensitiveSkinBtn.backgroundColor = .clear
        drySkinBtn.backgroundColor = .clear
        combinationSkinBtn.backgroundColor = .clear
        normalSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        drySkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        sensitiveSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        notSureBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        combinationSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
    }
    @IBAction func combinationSkinTouched(_ sender: Any) {
        playCombination()
        combinationSkinBtn.layer.backgroundColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        combinationSkinBtn.setTitleColor(UIColor(red: 253/255, green: 251/255, blue: 251/255, alpha: 1.0), for: UIControl.State.normal)
        notSureBtn.backgroundColor = .clear
        normalSkinBtn.backgroundColor = .clear
        sensitiveSkinBtn.backgroundColor = .clear
        oilySkinBtn.backgroundColor = .clear
        drySkinBtn.backgroundColor = .clear
        normalSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        drySkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        sensitiveSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        oilySkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        notSureBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
    }
    @IBAction func notSureSkinTouched(_ sender: Any) {
        playNotSure()
        notSureBtn.layer.backgroundColor = UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0).cgColor
        notSureBtn.setTitleColor(UIColor(red: 253/255, green: 251/255, blue: 251/255, alpha: 1.0), for: UIControl.State.normal)
        drySkinBtn.backgroundColor = .clear
        normalSkinBtn.backgroundColor = .clear
        sensitiveSkinBtn.backgroundColor = .clear
        oilySkinBtn.backgroundColor = .clear
        combinationSkinBtn.backgroundColor = .clear
        
        normalSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        drySkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        sensitiveSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        oilySkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        combinationSkinBtn.setTitleColor(UIColor(red: 187/255, green: 87/255, blue: 105/255, alpha: 1.0), for: UIControl.State.normal)
        
    }
    
    @IBAction func submitClicked(_ sender: Any) {
         
        if normalText.isHidden==false{
            goToHomePage()
        }
        if dryText.isHidden==false{
            goToHomePage()
        }
        if oilyText.isHidden==false{
            goToHomePage()
        }
        if sensitiveText.isHidden==false{
            goToHomePage()
        }
     
        if combinationText.isHidden==false{
            self.goToHome()
        }
        if notSureText.isHidden==false {
            print("test")
            performSegue(withIdentifier: "SurveySegue", sender: self)

        }else{
            createAlert(message: "Please fill atleast one skin condition")
        }
    }
    func createAlert(message: String) {
          let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
          let action = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(action)
          
          self.present(alert, animated: true, completion: nil)
      }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

      if segue.identifier == "SurveySegue" {
        _ = segue.destination as! OnBoardFifthVC
        }
       

        
    }
    
    func goToHome(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInVC = storyboard.instantiateViewController(withIdentifier: "HomePageFirstVC")
        loggedInVC.modalPresentationStyle = .fullScreen
        self.present(loggedInVC, animated: true, completion: nil)
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



//
//  OnBoardSixthVC.swift
//  MozBeauty
//
//  Created by Lukius Jonathan on 29/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class OnBoardSixthVC: UIViewController {

    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var btn2: UIButton!
 

    @IBAction func nextButton(_ sender: UIButton) {
        if sender.tag == 1{
            btn1.isSelected = true
            
        }
        if sender.tag == 2{
                   btn2.isSelected = true
               }
        if sender.tag == 3{
                   btn3.isSelected = true
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

//
//  HomePageFirstVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class HomePageFirstVC: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var contentview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let userData = User.getUserData(viewContext: getViewContext())
        print(userData)
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

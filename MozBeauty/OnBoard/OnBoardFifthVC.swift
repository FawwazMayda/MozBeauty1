//
//  OnBoardFifthVC.swift
//  MozBeauty
//
//  Created by Lukius Jonathan on 23/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class OnBoardFifthVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var circleEmpty: UIImageView!
    
    let pertanyaan=["Skin Apperance","Pores","Acne","Skin Feel"]
    let pertanyaanSkinAppearance=["Smooth Texture","Greasy Appearance","Flaky and rough skin","Oily T-zone and dry cheeks","Have a reaction to specific environtment ( example : during hot weather skin becomes red and itchy)"]
    let pertanyaanPores = ["Fine pores","Open/Big pores","No Blemishes"]
    let pertanyaanAcne=["Few or no break outs","Prone to breakouts","Breakouts only on forehead, chin and nose"]
    let pertanyaanSkinFeel=["Itching","Skin feels tight","Skin feels itchy and tight","Feels itchy while wearing tight clothes"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pertanyaan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        cell.textLabel?.text=pertanyaan[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        
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

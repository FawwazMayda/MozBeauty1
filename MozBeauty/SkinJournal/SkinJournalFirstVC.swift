//
//  SkinJournalFirstVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class SkinJournalFirstVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var productName: UILabel!
    @IBOutlet var productCategory: UILabel!
    @IBOutlet weak var journalTableView: UITableView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
   var tap : UITapGestureRecognizer?
        var viewModel = ViewModel()
        override func viewDidLoad() {
            super.viewDidLoad()
            
            journalTableView.delegate = self
            journalTableView.dataSource = self
            let nib = UINib(nibName: "JournalTableCell", bundle: nil)
            journalTableView.register(nib, forCellReuseIdentifier: JournalTableCell.identifier)
            bindProductView()
            initTap()
            // Do any additional setup after loading the view.
        }
        
        func initTap() {
            tap = UITapGestureRecognizer(target: self, action: #selector(productTapped(_:)))
            tap?.delegate = self
            productImageView.addGestureRecognizer(tap!)
            productImageView.isUserInteractionEnabled = true
        }
        
        @objc func productTapped(_ recognizer: UITapGestureRecognizer) {
            print("Tapped")
            performSegue(withIdentifier: "addNewProduct", sender: self)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            journalTableView.reloadData()
        }
        
        @IBAction func tapped(_ sender: Any) {
            performSegue(withIdentifier: "addNewJournal", sender: self)
        }
        
        func stylelize() {
            self.productView.layer.cornerRadius = 15.0
        }
        
        func bindProductView() {
            if let photoData = viewModel.productModel?.foto {
                self.productImageView.image = UIImage(data: photoData)
                self.productName.text = viewModel.productModel?.namaproduk
                self.productCategory.text = viewModel.productModel?.kategori
            } else {
                self.productImageView.image = #imageLiteral(resourceName: "Button add products")
            }
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "addNewJournal" {
                guard let indexPath = sender as? IndexPath else {fatalError("Error")}
                if let destVC = segue.destination as? SkinJournalThird {
                    destVC.journalModel = viewModel.allJournalModel[indexPath.section]
                    destVC.viewModel = viewModel
                    destVC.index = indexPath.section
                }
            } else if segue.identifier == "addNewProduct" {
                if let destVC = segue.destination as? SkinJournalSecondVC {
                    destVC.productModel = viewModel.productModel
                    destVC.viewModel = viewModel
                }
            }
        }
    }

    extension SkinJournalFirstVC: UITableViewDelegate,UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return viewModel.allJournalModel.count
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            4.0
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return UIView()
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return generateCell(indexPath: indexPath)
        }
        
        func generateCell(indexPath: IndexPath) -> UITableViewCell {
            guard let cell = journalTableView.dequeueReusableCell(withIdentifier: JournalTableCell.identifier, for: indexPath) as? JournalTableCell else {fatalError("Cant generate cell")}
            let currentModel = viewModel.allJournalModel[indexPath.section]
            if let photo=currentModel.photo {
                cell.headJournalLabel.text = "Day: \(currentModel.daycount)"
                cell.journalImageView.image = UIImage(data: photo)
            } else {
                cell.headJournalLabel.text = "You haven't create journal Today"
                cell.journalImageView.image = UIImage(systemName: "folder.fill")
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            journalTableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "addNewJournal", sender: indexPath)
        }
    }

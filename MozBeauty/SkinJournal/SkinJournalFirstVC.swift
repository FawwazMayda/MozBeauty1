//
//  SkinJournalFirstVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class SkinJournalFirstVC: UIViewController, UIGestureRecognizerDelegate {
    // Here is some comment
    @IBOutlet weak var productImageContainer: UIView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productCategory: UILabel!
    @IBOutlet weak var journalTableView: UITableView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    var tap : UITapGestureRecognizer?
    var viewModel = ViewModel.shared
    
        override func viewDidLoad() {
            super.viewDidLoad()
            print("journal did load")
            journalTableView.delegate = self
            journalTableView.dataSource = self
            let nib = UINib(nibName: "JournalTableCell", bundle: nil)
            journalTableView.register(nib, forCellReuseIdentifier: JournalTableCell.identifier)
            tapGesture(isAdding: true)
            stylelize()
            // Do any additional setup after loading the view.
        }
    
        override func viewWillAppear(_ animated: Bool) {
               super.viewWillAppear(animated)
               viewModel.createEmptyJournal()
               print("Journal will appear")
               bindProductView()
               journalTableView.reloadData()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Journal did appear")
    }
        
    func tapGesture(isAdding: Bool) {
        if isAdding {
            tap = UITapGestureRecognizer(target: self, action: #selector(productTapped(_:)))
            tap?.delegate = self
            productImageView.addGestureRecognizer(tap!)
            productImageView.isUserInteractionEnabled = true
        } else {
            productImageView.removeGestureRecognizer(tap!)
        }
    }
        
        @objc func productTapped(_ recognizer: UITapGestureRecognizer) {
            print("Tapped")
            if !viewModel.isProductCreated {
                performSegue(withIdentifier: "addNewProduct", sender: self)
            }
        }
        
        @IBAction func tapped(_ sender: Any) {
            performSegue(withIdentifier: "addNewJournal", sender: self)
        }
        
        func stylelize() {
            self.productImageContainer.layer.cornerRadius = self.productImageContainer.frame.size.width / 2.0
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
                    destVC.viewModel = viewModel
                    destVC.index = indexPath.section
                    if viewModel.allJournalModel[indexPath.section].photo != nil {
                        destVC.isEditingJournal = true
                    }
                }
            } else if segue.identifier == "addNewProduct" {
                if let destVC = segue.destination as? SkinJournalSecondVC {
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
            return 8.0
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
            let totalDay = viewModel.productModel!.durasi
            if let photo=currentModel.photo {
                let acneScore = viewModel.allJournalModel[indexPath.row].acne
                let wrinkleScore = viewModel.allJournalModel[indexPath.row].foreheadwrinkle
                cell.headJournalLabel.text = "Day \(currentModel.daycount) / \(totalDay)"
                cell.journalImageView.image = UIImage(data: photo)
                cell.descJournalLabel.text = String(format: "Acne: %.2f, Wrinke: %.2f", acneScore,wrinkleScore)
            } else {
                cell.headJournalLabel.text = "Add a New Journal"
                cell.journalImageView.image = UIImage(systemName: "folder.fill")
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            journalTableView.deselectRow(at: indexPath, animated: true)
            
            if indexPath.section==0 {
                performSegue(withIdentifier: "addNewJournal", sender: indexPath)
            }
        }
    }

//
//  SkinJournalFirstVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class SkinJournalFirstVC: UIViewController {

    @IBOutlet weak var journalTableView: UITableView!
    @IBOutlet weak var productView: UIView!
    
    var viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        journalTableView.delegate = self
        journalTableView.dataSource = self
        let nib = UINib(nibName: "JournalTableCell", bundle: nil)
        journalTableView.register(nib, forCellReuseIdentifier: JournalTableCell.identifier)
        // Do any additional setup after loading the view.
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewJournal" {
            guard let indexPath = sender as? IndexPath else {fatalError("Error")}
            if indexPath.section != 0 {
                if let destVC = segue.destination as? SkinJournalThird {
                    destVC.journalModel = viewModel.allJournalModel[indexPath.section]
                }
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


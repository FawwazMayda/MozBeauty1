//
//  AddProductsFirstVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class HistoryProductsFirstVC: UIViewController {
    
    @IBOutlet weak var journalHistoryTV: UITableView!
    var viewModel = ViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("producthistory did load")
        journalHistoryTV.delegate = self
        journalHistoryTV.dataSource = self
        let nib = UINib(nibName: "JournalTableCell", bundle: nil)
        journalHistoryTV.register(nib, forCellReuseIdentifier: JournalTableCell.identifier)
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

extension HistoryProductsFirstVC: UITableViewDelegate,UITableViewDataSource {
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
        guard let cell = journalHistoryTV.dequeueReusableCell(withIdentifier: JournalTableCell.identifier, for: indexPath) as? JournalTableCell else {fatalError("Cant generate cell")}
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
        journalHistoryTV.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "addNewJournal", sender: indexPath)
    }
}

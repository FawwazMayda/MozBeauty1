//
//  JournalTableCell.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 24/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class JournalTableCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var journalImageView: UIImageView!
    static let identifier = "JournalCell"
    @IBOutlet weak var descJournalLabel: UILabel!
    @IBOutlet weak var headJournalLabel: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("FROM XIB")
        style()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func style() {
        self.journalImageView.layer.cornerRadius = self.journalImageView.frame.size.width / 2
        self.journalImageView.layer.masksToBounds = true
        self.journalImageView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 20.0
        
    }
    
}

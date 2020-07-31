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
        self.imageContainer.layer.cornerRadius = self.imageContainer.frame.size.width / 2.0
        self.containerView.layer.cornerRadius = 20.0
        self.imageContainer.layer.masksToBounds = true
    }
    
}

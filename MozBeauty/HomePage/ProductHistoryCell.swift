//
//  ProductHistoryCell.swift
//  MozBeauty
//
//  Created by Feby Lailani on 05/08/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class ProductHistoryCell: UICollectionViewCell {
    @IBOutlet weak var prodNameLabel: UILabel!
    @IBOutlet weak var prodImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        prodImage.layer.cornerRadius = 15
        
    }
}

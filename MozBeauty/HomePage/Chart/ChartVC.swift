//
//  ChartVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 04/08/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import SwiftUI

class ChartVC: UIViewController {

    var acneData = [Double]()
    var wrinkleData = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Gathered : \(acneData.count) for chart data")
        view.backgroundColor = .green
        // Do any additional setup after loading the view.
        let contentView = UIHostingController(rootView: ChartContentView())
        addChild(contentView)
        view.addSubview(contentView.view)
        setup(contentView: contentView)
    }
    
    func setup(contentView: UIViewController) {
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

//
//  ChartContentView.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 05/08/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct ChartContentView: View {
    @ObservedObject var journalViewModel = ViewModel.shared
    var body: some View {
        HStack {
            Spacer()
            LineChartView(data: journalViewModel.acneData, title: "Acne")
            LineChartView(data: journalViewModel.wrinkleData, title: "Wrinkle")
            Spacer()
          
        }
        
    }
}

struct ChartContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartContentView()
    }
}

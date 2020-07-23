//
//  VisionModel.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 23/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Vision
import CoreML
import UIKit

class AgeModel {
    
    var delegate: FaceServiceDelegate?
    func detectAge(image: CIImage) {
          print("Try Detecting")
          guard let model = try? VNCoreMLModel(for: AgeNet().model) else {
              fatalError("Cant load model")
          }
          
          let res = VNCoreMLRequest(model: model) { [weak self] res, error in
              guard let resc = res.results as? [VNClassificationObservation],let conf = res.results as? [VNObservation],let topRes = resc.first else {
                  fatalError("No Results")
              }
              for i in 0..<resc.count {
                  let className = resc[i].identifier
                  let confScore = conf[i].confidence
                  print("\(className) with confidence: \(confScore)")
              }
              print(topRes.identifier)
            self?.delegate?.didGetAgePrediction(topRes.identifier)
          }
          
          let handler = VNImageRequestHandler(ciImage: image)
          DispatchQueue.global(qos: .userInteractive).async {
              do {
                  try handler.perform([res])
              } catch {
                  print("Error")
              }
          }
      }
}

//
//  SkinJournalThird.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 23/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class SkinJournalThird: UIViewController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var skinAgeLabel: UILabel!
    @IBOutlet weak var acneLabel: UILabel!
    @IBOutlet weak var wrinkleLabel: UILabel!
    var tapGesture: UITapGestureRecognizer?
    
    var ageModel = AgeModel()
    var visionModel = NetReq()

    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        visionModel.delegate = self
        ageModel.delegate = self
    }
    
    func addGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(recognizer:)))
        tapGesture?.delegate = self
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(tapGesture!)
    }
    
    @objc func handleTapGesture(recognizer: UITapGestureRecognizer) {
        print("ImageView Tapped")
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.delegate = self
        present(picker, animated: true,completion: nil)
    }
}

extension SkinJournalThird: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let img = info[.originalImage] as? UIImage else {fatalError("Cant obtain Images")}
        
        imageView.image = img
        guard let cgImage = CIImage(image: img) else {
                  fatalError("Cant convert to CGIMage")
        }
        ageModel.detectAge(image: cgImage)
        visionModel.doRequestsAlamo(withImage: img)
        dismiss(animated: true)
    }
}

extension SkinJournalThird: FaceServiceDelegate {
    func didGetAgePrediction(_ string: String) {
        DispatchQueue.main.async {
            self.skinAgeLabel.text = "Skin Age: \(string)"
        }
    }
    
    func didGetSkinPrediction(_ skinResult: FaceResult) {
        DispatchQueue.main.async {
            self.acneLabel.text = "Acne Score: \(skinResult.result.acne.confidence)"
            self.wrinkleLabel.text = "Wrinkle Score: \(skinResult.result.forehead_wrinkle.confidence)"
        }
    }
    
    
}

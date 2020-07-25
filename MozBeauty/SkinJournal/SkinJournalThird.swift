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
    
    var journalModel: Journal? 
    var ageModel = AgeModel()
    var visionModel = NetReq()

    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        visionModel.delegate = self
        ageModel.delegate = self
        if journalModel == nil {
            print("Creating empty Journal")
            journalModel = Journal(context: ViewModel.globalContext)
        }
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
    
    func updateUI() {
        if let currentModel = journalModel {
            DispatchQueue.main.async {
                   self.imageView.image = UIImage(data: currentModel.photo!)
                         self.acneLabel.text = "Acne Score: \(currentModel.acne)"
                         self.wrinkleLabel.text = "Wrinkle Score: \(currentModel.foreheadwrinkle)"
                self.skinAgeLabel.text = "Skin age: \(currentModel.skinage!)"
            }
        }
    }
    @IBAction func doneTapped(_ sender: Any) {
        if let currentModel = journalModel {
            currentModel.save()
            dismiss(animated: true, completion: nil)
        }
    }
}

extension SkinJournalThird: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let img = info[.originalImage] as? UIImage else {fatalError("Cant obtain Images")}
        
        //imageView.image = img
        journalModel?.photo = img.jpegData(compressionQuality: 0.8)!
        guard let cgImage = CIImage(image: img) else {
                  fatalError("Cant convert to CGIMage")
        }
        ageModel.detectAge(image: cgImage)
        visionModel.doRequestsAlamo(withImage: img)
        dismiss(animated: true)
        self.imageView.removeGestureRecognizer(tapGesture!)
    }
}

extension SkinJournalThird: FaceServiceDelegate {
    func didGetAgePrediction(_ string: String) {
        journalModel?.skinage = string
        self.updateUI()
    }
    
    func didGetSkinPrediction(_ skinResult: FaceResult) {
        journalModel?.acne = skinResult.result.acne.confidence
        journalModel?.foreheadwrinkle = skinResult.result.forehead_wrinkle.confidence
        self.updateUI()
       
    }
    
    
}

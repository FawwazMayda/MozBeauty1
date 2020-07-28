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
    @IBOutlet var faceConditionTextField: UITextField!
    
    var tapGesture: UITapGestureRecognizer?
    var journalModel: Journal?
    var viewModel: ViewModel?
    var index = 0
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
        
        self.imageView.image = #imageLiteral(resourceName: "Button add products")
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
        DispatchQueue.main.async {
            if let photo = self.viewModel?.allJournalModel[self.index].photo, let acneScore = self.viewModel?.allJournalModel[self.index].acne, let wrinkleScore = self.viewModel?.allJournalModel[self.index].foreheadwrinkle, let skinAge = self.viewModel?.allJournalModel[self.index].skinage {
                self.imageView.image = UIImage(data: photo)
                self.acneLabel.text = "Acne score: \(acneScore)"
                self.wrinkleLabel.text = "Wrinkle score: \(wrinkleScore)"
                self.skinAgeLabel.text = "Skin age: \(skinAge)"
            }
        }
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        viewModel?.allJournalModel[index].id_product = viewModel?.productModel?.id
        viewModel?.allJournalModel[index].desc = faceConditionTextField.text
        viewModel?.allJournalModel[index].daycount = viewModel?.currentDay as! Int16
        print("saved with day Count: \(viewModel?.currentDay)")
        viewModel?.allJournalModel[index].save()
        
        if let _ = viewModel?.allJournalModel[index].save() {
            
            if viewModel?.currentDay == viewModel?.productModel?.durasi {
                let userDefault = UserDefaults.standard
                userDefault.set(nil, forKey: "currentUsedProduct")
            }
            
            dismiss(animated: true, completion: nil)
        }
    }
}

extension SkinJournalThird: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let img = info[.originalImage] as? UIImage else {fatalError("Cant obtain Images")}
        
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
    func didGetSkinPredictionError(_ error: String) {
        let alert = UIAlertController(title: "Error Detecting", message: "API can't process the data currently", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        
        self.present(alert, animated: true) {
            self.addGesture()
        }
    }
    
    
    func didGetAgePrediction(_ string: String) {
        viewModel?.allJournalModel[index].skinage = string
        self.updateUI()
    }
    
    func didGetSkinPrediction(_ skinResult: FaceResult) {
        viewModel?.allJournalModel[index].acne = skinResult.result.acne.confidence
        viewModel?.allJournalModel[index].foreheadwrinkle = skinResult.result.acne.confidence
        self.updateUI()
       
    }
}

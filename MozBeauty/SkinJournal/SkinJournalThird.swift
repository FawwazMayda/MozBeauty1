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
            self.imageView.image = UIImage(data: (self.viewModel?.allJournalModel[self.index].photo)!)
            self.acneLabel.text = "Acne Score: \(self.viewModel?.allJournalModel[self.index].acne)"
            self.wrinkleLabel.text = "Wrinkle Score: \(self.viewModel?.allJournalModel[self.index].foreheadwrinkle)"
        }
    }
    @IBAction func doneTapped(_ sender: Any) {
        viewModel?.allJournalModel[index].id_product = viewModel?.productModel?.id
        viewModel?.allJournalModel[index].daycount = viewModel?.currentDay as! Int16
        viewModel?.allJournalModel[index].save()
        dismiss(animated: true, completion: nil)
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

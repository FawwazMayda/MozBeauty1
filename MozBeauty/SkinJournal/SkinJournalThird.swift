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
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
        var isEditingJournal: Bool = false
        var vSpinner: UIView?
        var tapGesture: UITapGestureRecognizer?
        var viewModel: ViewModel?
        var index = 0
        var ageModel = AgeModel()
        var visionModel = NetReq()

        override func viewDidLoad() {
            super.viewDidLoad()
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            //tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
            
            addGesture()
            addAlertInfo()
            visionModel.delegate = self
            ageModel.delegate = self
            doneBarButton.isEnabled = false
        }
        
        func addGesture() {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(recognizer:)))
            tapGesture?.delegate = self
            
            self.imageView.image = #imageLiteral(resourceName: "Button add products")
            self.imageView.isUserInteractionEnabled = true
            self.imageView.addGestureRecognizer(tapGesture!)
        }
    
        func addAlertInfo() {
            let message = """
            Before taking a picture, please ensure that :
            \n
            1. You have enough light source in front of you\n
            2. Nothing is covering your face ( ex: hair, glasses, etc)\n
            3. You have a plain background\n 4. Capture your whole face in selfie camera ( don’t take picture for part of your face)\n
            if you take picture other than your face, the report will give an error alert\n ( means you need to retake the picture)\n

            """
             let alert = UIAlertController(title: "Reminders", message: message, preferredStyle: .alert)
                       
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       
            self.present(alert, animated: true, completion: nil)
            
        }
        
        @objc func dismissKeyboard() {
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            view.endEditing(true)
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
            
            if isEditingJournal {
                //Editing new Journal
                viewModel?.allJournalModel[index].id_product = viewModel?.productModel?.id
                viewModel?.allJournalModel[index].datecreated = Date()
                viewModel?.allJournalModel[index].desc = faceConditionTextField.text
                
            } else {
                //Creating new Journal
                viewModel?.allJournalModel[index].id = UUID().uuidString
                viewModel?.allJournalModel[index].datecreated = Date()
                viewModel?.allJournalModel[index].id_product = viewModel?.productModel?.id
                viewModel?.allJournalModel[index].desc = faceConditionTextField.text
                viewModel?.allJournalModel[index].daycount = viewModel?.currentDay as! Int16
            }
            /*
            viewModel?.allJournalModel[index].id = UUID().uuidString
            viewModel?.allJournalModel[index].datecreated = Date()
            viewModel?.allJournalModel[index].id_product = viewModel?.productModel?.id
            viewModel?.allJournalModel[index].desc = faceConditionTextField.text
            viewModel?.allJournalModel[index].daycount = viewModel?.currentDay as! Int16
            */
            print("saved with day Count: \(viewModel?.currentDay)")
            
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
            
            viewModel?.allJournalModel[index].photo = img.jpegData(compressionQuality: 0.8)!
            guard let cgImage = CIImage(image: img) else {
                      fatalError("Cant convert to CGIMage")
            }
            
            ageModel.detectAge(image: cgImage)
            visionModel.doRequestsAlamo(withImage: img)
            dismiss(animated: true)
            self.imageView.removeGestureRecognizer(tapGesture!)
            self.showSpinner(onView: self.view)
        }
    }

    extension SkinJournalThird: FaceServiceDelegate {
        func didGetSkinPredictionError(_ error: String) {
            self.removeSpinner()
            var message = ""
            switch error {
            case "NO_FACE_FOUND":
                message = "No Face is detected or the Face is too small"
            case "INVALID_IMAGE_FACE":
                message = "Photo may contain too many faces or the Face is too small"
            default:
                message = "API can't process the data currently"
            }
            
            let alert = UIAlertController(title: "Error Detecting", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                self.addGesture()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
        func didGetAgePrediction(_ string: String) {
            viewModel?.allJournalModel[index].skinage = string
            self.updateUI()
        }
        
        func didGetSkinPrediction(_ skinResult: FaceResult) {
            viewModel?.allJournalModel[index].acne = skinResult.result.acne.confidence * 100
            viewModel?.allJournalModel[index].foreheadwrinkle = skinResult.result.acne.confidence * 100
            self.updateUI()
            self.removeSpinner()
            self.doneBarButton.isEnabled = true
        }
    }


extension SkinJournalThird {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}

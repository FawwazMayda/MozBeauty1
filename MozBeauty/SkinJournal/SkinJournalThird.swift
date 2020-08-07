//
//  SkinJournalThird.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 23/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class SkinJournalThird: UIViewController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var skinAgeLabel: UILabel!
    @IBOutlet weak var acneLabel: UILabel!
    @IBOutlet weak var wrinkleLabel: UILabel!
    @IBOutlet var faceConditionTextField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    // Whether editing old journal or making a new ones
    var isEditingJournal: Bool = false
    var vSpinner: UIView?
    var tapGesture: UITapGestureRecognizer?
    //The actual model from Core Data
    var viewModel: ViewModel?
    //The actual index of journal
    var index = 0
    //Keeping the temporary Model for the View
    var tempJournal = TempJournalModel() {
        didSet {
            self.updateUI()
        }
    }
    var ageModel = AgeModel()
    var visionModel = NetReq()

    override func viewDidLoad() {
            super.viewDidLoad()
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            //tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        if isEditingJournal {
            tempJournal.acneSore = viewModel?.allJournalModel[index].acne
            tempJournal.wrinkleScore = viewModel?.allJournalModel[index].foreheadwrinkle
            tempJournal.photo = UIImage(data: (viewModel?.allJournalModel[index].photo)!)
            tempJournal.skinage = viewModel?.allJournalModel[index].skinage
            faceConditionTextField.text = viewModel?.allJournalModel[index].desc
            updateUI()
            changePhotoButton.isHidden = false
        } else {
            changePhotoButton.isHidden = true
            gesture(isAdding: true)
        }
            
            visionModel.delegate = self
            ageModel.delegate = self
            doneBarButton.isEnabled = false
    }
        
    func gesture(isAdding: Bool) {
        if isAdding {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(recognizer:)))
                       tapGesture?.delegate = self
                       
                       self.imageView.image = #imageLiteral(resourceName: "Button add products")
                       self.imageView.isUserInteractionEnabled = true
                       self.imageView.addGestureRecognizer(tapGesture!)
        } else {
            self.imageView.removeGestureRecognizer(tapGesture!)
        }
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
            selectImage()
    }
    
    func selectImage() {
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
            if let photo = self.tempJournal.photo,let acneScore = self.tempJournal.acneSore, let wrinkleScore = self.tempJournal.wrinkleScore, let skinAge = self.tempJournal.skinage {
                self.imageView.image = photo
                self.acneLabel.text = "Acne score: \(String(format: "%.2f", acneScore))"
                self.wrinkleLabel.text = "Wrinkle score: \(String(format: "%.2f", wrinkleScore))"
                self.skinAgeLabel.text = "Skin age: \(skinAge)"
            }
        }
    }
        
    @IBAction func doneTapped(_ sender: Any) {
            
            if isEditingJournal {
                //Editing new Journal
                viewModel?.allJournalModel[index].datecreated = Date()
            } else {
                //Creating new Journal
                viewModel?.allJournalModel[index].id = UUID().uuidString
                viewModel?.allJournalModel[index].id_product = viewModel?.productModel?.id
                viewModel?.allJournalModel[index].datecreated = Date()
                viewModel?.allJournalModel[index].daycount = viewModel?.currentDay as! Int16
            }
        viewModel?.allJournalModel[index].photo = tempJournal.photo?.jpegData(compressionQuality: 0.8)!
        viewModel?.allJournalModel[index].desc = faceConditionTextField.text
        viewModel?.allJournalModel[index].acne = tempJournal.acneSore!
        viewModel?.allJournalModel[index].foreheadwrinkle = tempJournal.wrinkleScore!
        viewModel?.allJournalModel[index].skinage = tempJournal.skinage
        print("saved with day Count: \(viewModel?.currentDay)")
            
            if let _ = viewModel?.allJournalModel[index].save() {
                
                if viewModel?.currentDay == viewModel?.productModel?.durasi {
                    let userDefault = UserDefaults.standard
                    userDefault.set(nil, forKey: "currentUsedProduct")
                }
                self.navigationController?.popViewController(animated: true)
            }
    }
    
    @IBAction func changePhotoTapped(_ sender: Any) {
        selectImage()
    }
        
    }

    extension SkinJournalThird: UIImagePickerControllerDelegate {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let img = info[.originalImage] as? UIImage else {fatalError("Cant obtain Images")}
            
            //viewModel?.allJournalModel[index].photo = img.jpegData(compressionQuality: 0.8)!
            tempJournal.photo = img
            guard let cgImage = CIImage(image: img) else {
                      fatalError("Cant convert to CGIMage")
            }
            
            ageModel.detectAge(image: cgImage)
            visionModel.doRequestsAlamo(withImage: img)
            dismiss(animated: true)
            if !isEditingJournal {
                gesture(isAdding: false)
            }
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
                self.gesture(isAdding: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
        func didGetAgePrediction(_ string: String) {
            tempJournal.skinage = string
            //self.updateUI()
        }
        
        func didGetSkinPrediction(_ skinResult: FaceResult) {
            tempJournal.acneSore = skinResult.result.acne.confidence * 100
            tempJournal.wrinkleScore = skinResult.result.forehead_wrinkle.confidence * 100
            //self.updateUI()
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

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
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet var faceConditionTextField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    //Whether journal can be edited (making or editing)
    var isViewedOnly: Bool = false
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
    
    var isFaceConditionCompleted = false {
        didSet {
            buttonCondition()
        }
    }
    var isFacePhotoCompleted = false {
        didSet {
            buttonCondition()
        }
    }
    var ageModel = AgeModel()
    var visionModel = NetReq()

    override func viewDidLoad() {
            super.viewDidLoad()
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        visionModel.delegate = self
        ageModel.delegate = self
        faceConditionTextField.autocorrectionType = .no
        setTodayLabel()
        
        if isEditingJournal {
            tempJournal.acneSore = viewModel?.allJournalModel[index].acne
            tempJournal.wrinkleScore = viewModel?.allJournalModel[index].foreheadwrinkle
            tempJournal.photo = UIImage(data: (viewModel?.allJournalModel[index].photo)!)
            tempJournal.skinage = viewModel?.allJournalModel[index].skinage
            faceConditionTextField.text = viewModel?.allJournalModel[index].desc
            updateUI()
            isFaceConditionCompleted = true
            isFacePhotoCompleted = true
        } else {
            changePhotoButton.isHidden = true
            gesture(isAdding: true)
        }
        
        faceConditionTextField.addTarget(self, action: #selector(self.checkFaceConditionTextField), for: .editingChanged)
        faceConditionTextField.delegate = self
        
        buttonCondition()
    }
    
    func buttonCondition() {
        //will be hidden if face not completed or is viewedonly
        changePhotoButton.isHidden = (isViewedOnly || !isFacePhotoCompleted) ? true : false
        doneBarButton.isEnabled = (isFacePhotoCompleted && isFaceConditionCompleted && !isViewedOnly) ? true : false
    }
 
    @objc func checkFaceConditionTextField() {
        if let currentText = faceConditionTextField.text {
            if currentText == "" {
                isFaceConditionCompleted = false
            } else {
                isFaceConditionCompleted = true
            }
        } else {
            isFaceConditionCompleted = false
        }
    }
    
    func setTodayLabel() {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        todayDateLabel.text = formatter.string(from: Date())
    }
        
    func gesture(isAdding: Bool) {
        // Add or remove tap Gesture on ImageView
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
    
    func alertResourceNotAvailable(sourceType: UIImagePickerController.SourceType) {
            //Send alert regarding not availabe resource type
            var message = ""
            switch sourceType {
            case .camera:
                message = "Camera not available"
                print(message)
            case .photoLibrary:
                message = "Photo Library not available"
                print(message)
            case .savedPhotosAlbum:
                message = "Saved Photos Album not available"
                print(message)
            default:
                message = "Source not available"
                print(message)
            }
            
            let alertUI = UIAlertController(title: "Try Again", message: message , preferredStyle: .alert)
            alertUI.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertUI, animated: true, completion: nil)
        }
    
        func pickerWith(source: UIImagePickerController.SourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = source
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
    
        func selectImage() {
            let sheetUI = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    // Do the picker with camera
                    self.pickerWith(source: .camera)
                } else {
                    self.alertResourceNotAvailable(sourceType: .camera)
                }
            }
            
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    // DO picker with photo library
                    self.pickerWith(source: .photoLibrary)
                } else {
                    self.alertResourceNotAvailable(sourceType: .photoLibrary)
                }
            }
            
            let savedAlbumAction = UIAlertAction(title: "Saved Photos Albums", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                    // Do picker with savedPhoto albums
                    self.pickerWith(source: .savedPhotosAlbum)
                } else {
                    self.alertResourceNotAvailable(sourceType: .savedPhotosAlbum)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            sheetUI.addAction(cameraAction)
            sheetUI.addAction(photoLibraryAction)
            sheetUI.addAction(savedAlbumAction)
            sheetUI.addAction(cancelAction)
            sheetUI.popoverPresentationController?.sourceView = self.view
            present(sheetUI, animated: true, completion: nil)
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
                viewModel?.allJournalModel[index].daycount = viewModel?.currentDay ?? 0
            }
        
        viewModel?.allJournalModel[index].photo = tempJournal.photo?.jpegData(compressionQuality: 0.8) ?? nil
        viewModel?.allJournalModel[index].desc = faceConditionTextField.text ?? ""
        viewModel?.allJournalModel[index].acne = tempJournal.acneSore ?? 0
        viewModel?.allJournalModel[index].foreheadwrinkle = tempJournal.wrinkleScore ?? 0
        viewModel?.allJournalModel[index].skinage = tempJournal.skinage
        
        print("saved with day Count: \(String(describing: viewModel?.currentDay))")
        
        if viewModel?.currentDay == viewModel?.productModel?.durasi {
            //Set the false for curren product
            viewModel?.productModel?.iscurrentproduct = false
            if let _ = viewModel?.productModel?.save(), let _ = viewModel?.allJournalModel[index].save() {
                //Just get back to homepage
                viewModel?.delegate?.didNeedChartUpdate()
                viewModel?.isProductCreated = false
                viewModel?.delegate?.didNeedSync()
                self.dismiss(animated: true) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        } else {
            if let cur = viewModel?.allJournalModel[index].save() {
                //Get back to journal table
                viewModel?.delegate?.didNeedSync()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func changePhotoTapped(_ sender: Any) {
        selectImage()
    }
}

extension SkinJournalThird: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !isViewedOnly
    }
}

    extension SkinJournalThird: UIImagePickerControllerDelegate {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let img = info[.editedImage] as? UIImage else {fatalError("Cant obtain Images")}
            
            tempJournal.photo = img
            guard let cgImage = CIImage(image: img) else {
                      fatalError("Cant convert to CGIMage")
            }
            
            ageModel.detectAge(image: cgImage)
            visionModel.doRequestsAlamo(withImage: img)
            
            if !isEditingJournal {
                gesture(isAdding: false)
            }
            
            self.showSpinner(onView: self.view)
            dismiss(animated: true)
        }
    }

    extension SkinJournalThird: FaceServiceDelegate {
        func didGetSkinPredictionError(_ error: String) {
            isFacePhotoCompleted = false
            self.removeSpinner()
            var message = ""
            
            switch error {
            case "NO_FACE_FOUND":
                message = "No Face is detected or the Face is too small"
            case "INVALID_IMAGE_FACE":
                message = "Photo may contain too many faces or the Face is too small"
            default:
                message = """
                Before taking a picture, please ensure that :
                \n
                1. You have enough light source in front of you\n
                2. Nothing is covering your face ( ex: hair, glasses, etc)\n
                3. You have a plain background\n 4. Capture your whole face in selfie camera ( don’t take picture for part of your face)\n
                if you take picture other than your face, the report will give an error alert\n ( means you need to retake the picture)\n

                """
            }
            
            let alert = UIAlertController(title: "Error Detecting", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                self.gesture(isAdding: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
        func didGetAgePrediction(_ string: String) {
            tempJournal.skinage = string
        }
        
        func didGetSkinPrediction(_ skinResult: FaceResult) {
            tempJournal.acneSore = skinResult.result.acne.confidence * 100
            tempJournal.wrinkleScore = skinResult.result.forehead_wrinkle.confidence * 100
            self.removeSpinner()
            isFacePhotoCompleted = true
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

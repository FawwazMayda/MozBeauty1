//
//  SkinJournalSecondVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 25/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class SkinJournalSecondVC: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var viewModel: ViewModel?
    var tempProduct = TempProductModel()

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var durationPickerView: UIPickerView!
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var categoryTextField: UITextField!
    let categoryPicker = UIPickerView()
    
    var pickerValue = ["1 weeks","2 weeks","3 weeks"]
    var categoryValue = ["Cleanser","Exfoliator","Toner",
     "Serum","Face Oil","Sunscreen","Moisturizer","Facemask","Eyecream","Face treatment"]
        var tap: UITapGestureRecognizer?
    
    var isImageCompleted = false {
        didSet {
            doneEnableOrDisable()
        }
    }
    var isProductNameCompleted = false {
        didSet {
            doneEnableOrDisable()
        }
    }
    var isCategoryCompleted = false {
        didSet {
            doneEnableOrDisable()
        }
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.productImageView.layer.cornerRadius = 15.0
            durationPickerView.delegate = self
            durationPickerView.dataSource = self
            
            initTap()
            
            productTextField.tag = 1
            categoryTextField.tag = 2
            productTextField.delegate = self
            categoryTextField.delegate = self
            
            durationPickerView.tag = 1
            // Do any additional setup after loading the view.
            //Setup category text Field Picker
            categoryPicker.tag = 2
            categoryPicker.delegate = self
            categoryTextField.inputView = categoryPicker
            
            //Disable done button item
            doneBarButton.isEnabled = false
            
        }
        
        func initTap() {
            tap = UITapGestureRecognizer(target: self, action: #selector(chooseImage(_:)))
            tap?.delegate = self
            self.productImageView.isUserInteractionEnabled = true
            self.productImageView.addGestureRecognizer(tap!)
        }
    
    func doneEnableOrDisable() {
        if isImageCompleted && isCategoryCompleted && isProductNameCompleted {
            doneBarButton.isEnabled = true
        }
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
        
        @objc func chooseImage(_ recognizer: UITapGestureRecognizer) {
            selectImage()
        }
        
        @IBAction func doneTapped(_ sender: Any) {
            viewModel?.productModel?.durasi = tempProduct.durasi ?? 7
            viewModel?.productModel?.foto = tempProduct.photo?.jpegData(compressionQuality: 0.8)
            viewModel?.productModel?.kategori = categoryTextField.text
            viewModel?.productModel?.namaproduk = productTextField.text
            viewModel?.productModel?.iscurrentproduct = true
            
            if let _ = viewModel?.productModel?.save() {
                viewModel?.isProductCreated = true
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let img = info[.editedImage] as? UIImage else {fatalError("No Image chosen")}
            print("Picked edited Image")
            self.productImageView.image = img
            tempProduct.photo = img
            isImageCompleted = true
            dismiss(animated: true, completion: nil)
        }

    }

    extension SkinJournalSecondVC: UIPickerViewDelegate,UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if pickerView.tag == 1 {
                return pickerValue.count
            } else {
                return categoryValue.count
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView.tag == 1 {
                return pickerValue[row]
            } else {
                return categoryValue[row]
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if pickerView.tag == 1 {
                tempProduct.durasi = Int16((row + 1)*7)
            } else {
                categoryTextField.text = categoryValue[row]
            }
        }
    }

extension SkinJournalSecondVC: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            if textField.text != nil {
                isProductNameCompleted = true
            } else {
                isProductNameCompleted = false
            }
        } else {
            if textField.text != nil {
                isCategoryCompleted = true
            } else {
                isCategoryCompleted = true
            }
        }
        return true
    }
}

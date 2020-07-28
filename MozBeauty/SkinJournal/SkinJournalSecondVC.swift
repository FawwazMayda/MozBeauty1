//
//  SkinJournalSecondVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 25/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class SkinJournalSecondVC: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var productModel: ProductsUsed?
    var viewModel: ViewModel?

    @IBOutlet weak var durationPickerView: UIPickerView!
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var categoryTextField: UITextField!
    
    var pickerValue = ["1 weeks","2 weeks","3 weeks"]
        
        var tap: UITapGestureRecognizer?
        override func viewDidLoad() {
            super.viewDidLoad()
            durationPickerView.delegate = self
            durationPickerView.dataSource = self
            initTap()
            // Do any additional setup after loading the view.
            viewModel?.productModel?.durasi = Int16(7)
        }
        
        func initTap() {
            tap = UITapGestureRecognizer(target: self, action: #selector(chooseImage(_:)))
            tap?.delegate = self
            self.productImageView.isUserInteractionEnabled = true
            self.productImageView.addGestureRecognizer(tap!)
        }
        
        @objc func chooseImage(_ recognizer: UITapGestureRecognizer) {
            let picker = UIImagePickerController()
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
            } else {
                picker.sourceType = .photoLibrary
            }
            picker.delegate = self
            present(picker, animated: true, completion: nil)
            
        }
        
        @IBAction func doneTapped(_ sender: Any) {
            let userDefault = UserDefaults.standard
            userDefault.set(productModel?.id, forKey: "currentUsedProduct")
            viewModel?.productModel?.namaproduk = productTextField.text
            viewModel?.productModel?.kategori = categoryTextField.text
            if let _ = viewModel?.productModel?.save() {
                dismiss(animated: true, completion: nil)
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let img = info[.originalImage] as? UIImage else {fatalError("No Image chosen")}
            
            productImageView.image = img
            viewModel?.productModel?.foto = img.jpegData(compressionQuality: 0.8)
            dismiss(animated: true, completion: nil)
        }

    }

    extension SkinJournalSecondVC: UIPickerViewDelegate,UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerValue.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerValue[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            viewModel?.productModel?.durasi = Int16((row + 1)*7)
        }
    }

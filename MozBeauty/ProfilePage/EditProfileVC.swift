//
//  EditProfileVC.swift
//  MozBeauty
//
//  Created by Lukius Jonathan on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

var passImg: UIImage?

class EditProfileVC: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var allergiesTextField: UITextField!
    @IBOutlet weak var skinTextField: UITextField!
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImg()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    func setImg() {
           imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
           imgProfile.clipsToBounds=true
           imgProfile.layer.shadowRadius=10
           imgProfile.layer.shadowColor=UIColor.black.cgColor
           imgProfile.layer.shadowOffset=CGSize.zero
           imgProfile.layer.shadowOpacity=1
           imgProfile.layer.shadowPath = UIBezierPath(rect: imgProfile.bounds).cgPath
           
//           imgProfile.image = passImg!
       }
    
    @IBAction func saveBtn(_ sender: Any) {
        if (nameTextField.text == "") {
                   createAlert(message: "Name can't be blank")
               }
        if (allergiesTextField.text == "") {
                          createAlert(message: "Allergies can't be blank")
                      }
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func btnEditTapped(_ sender: Any) {
         let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.allowsEditing = true
                
                let actionSheet = UIAlertController(title: "Piih Foto Profil", message: "Choose from Photo Libary or Camera", preferredStyle: .actionSheet)
                
                actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
                    imagePickerController.sourceType = .camera
                    self.present(imagePickerController, animated: true, completion: nil)
                }))
                
                actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
                    imagePickerController.sourceType = .photoLibrary
                    self.present(imagePickerController, animated: true, completion: nil)
                }))
                
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(actionSheet, animated: true, completion: nil)
            }
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                var selectedImage: UIImage?
                
                if let editedImg = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                    selectedImage = editedImg
                }
                else if let originalImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    selectedImage = originalImg
                }
                
//               if let selectedImg = selectedImage {
//                           let selectedImgProfile = resizeImage(image: selectedImg, targetSize: CGSize(width: 250, height: 250))
//                           imgProfile.image = selectedImgProfile
//                       }
                
                picker.dismiss(animated: true, completion: nil)
            }
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true, completion: nil)
            }
            
            func createAlert(message: String) {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            }
            
        }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */




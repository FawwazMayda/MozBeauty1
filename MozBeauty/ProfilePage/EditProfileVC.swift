//
//  EditProfileVC.swift
//  MozBeauty
//
//  Created by Lukius Jonathan on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import CoreData

var passImg: UIImage?

class EditProfileVC: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var allergiesTextField: UITextField!
    @IBOutlet weak var skinTextField: UITextField!
    
    var userModel: User?
    
    var userModel2: User?

    @IBOutlet weak var imgProfile: UIImageView!
    var passImg: UIImage?


    override func viewDidLoad() {
        super.viewDidLoad()
        loadExample()
        loadExampleSkin()
        setImg()
        if let currentImage = userModel?.fotoprofil{
            imgProfile.image = UIImage.init(data: currentImage)
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    
        nameTextField.text=userModel?.nama
        genderTextField.text=userModel?.gender
        allergiesTextField.text=userModel?.allergy
        skinTextField.text=userModel2?.hitungscore
    }
    func setImg() {
           imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
           imgProfile.clipsToBounds=true
           imgProfile.layer.shadowRadius=10
           imgProfile.layer.shadowColor=UIColor.black.cgColor
           imgProfile.layer.shadowOffset=CGSize.zero
           imgProfile.layer.shadowOpacity=1
           imgProfile.layer.shadowPath = UIBezierPath(rect: imgProfile.bounds).cgPath
           
           imgProfile.image = passImg
       }
    
    @IBAction func saveBtn(_ sender: Any) {
        if (nameTextField.text == "") {
                   createAlert(message: "Name can't be blank")
               }
        if (allergiesTextField.text == "") {
                          createAlert(message: "Allergies can't be blank")
                      }
        else if imgProfile.image != passImg {
            showSpinnerr()
            userModel?.fotoprofil=imgProfile.image?.jpegData(compressionQuality: 0.9)
    }
        
        userModel?.nama=nameTextField.text
        userModel?.allergy=allergiesTextField.text
        do {
            try ViewModel.globalContext.save()
        } catch  {
            print(error)
        }
        nameTextField.text=userModel?.nama
        allergiesTextField.text=userModel?.allergy
        dismiss(animated: true, completion: nil )
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func btnEditTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.allowsEditing = true
                
                let actionSheet = UIAlertController(title: "Choose Profile Photo", message: "Take from camera library or your camera", preferredStyle: .actionSheet)
                
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
                
                if let selectedImg = selectedImage {
                    let selectedImgProfile = resizeImage(image: selectedImg, targetSize: CGSize(width: 250, height: 250))
                    imgProfile.image = selectedImgProfile
                }
                
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
    func loadExample() {
        let req : NSFetchRequest<User> = User.fetchRequest()
        do {
            let res = try ViewModel.globalContext.fetch(req)
            userModel = res.last
            //firstItem.allergy
            //firstItem.nama
            
        } catch {
            print(error)
        }
    }
    func loadExampleSkin() {
        let req : NSFetchRequest<User> = User.fetchRequest()
        do {
            let res = try ViewModel.globalContext.fetch(req)
            userModel2 = res[0]
            
            //firstItem.allergy
            //firstItem.nama
            
        } catch {
            print(error)
        }
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



var aView: UIView?

extension UIViewController {
    
    func showSpinnerr() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func removeSpinnerr() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

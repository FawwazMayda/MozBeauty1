//
//  HomePageFirstVC.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 20/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import CoreData
import Charts

class HomePageFirstVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var viewSkinCond: UIView!
    @IBOutlet weak var fotoSkin: UIImageView!
    @IBOutlet weak var skinLabel: UILabel!
    @IBOutlet weak var journalImageView: UIImageView!
    @IBOutlet weak var journalHeadLabel: UILabel!
    @IBOutlet weak var journalDescLabel: UILabel!
    @IBOutlet weak var productImageContainer: UIView!
    @IBOutlet weak var productImageView: RoundImg!
    @IBOutlet weak var productHeadLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var profileAva: UIButton!
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productCollView: UICollectionView!
    
    var userModel: User?
    var userModel2: User?
    let journalViewModel = ViewModel.shared
    let productImages = ["plus", "plus"]
    let productNames = ["a", "b"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalViewModel.loadProduct()
        journalViewModel.delegate = self
        productCollView.delegate = self
        productCollView.dataSource = self
        print("Homepage did load")
        loadExampleSkin()
        loadExample()
        setTodayLabel()
        
        productView.layer.cornerRadius = 15.0
        productImageContainer.layer.cornerRadius = productImageContainer.frame.width / 2.0
        
        nameLabel.text=userModel2?.nama
        
//        if let currentImage = userModel?.fotoprofil{
//                   imageAva.image = UIImage.init(data: currentImage)
//               }
        
        if userModel!.hitungscore=="Normal" || userModel2!.hitungscore=="Normal"{
            fotoSkin.image=#imageLiteral(resourceName: "Homepage-normal")
            skinLabel.text="Normal Skin"

        }
        else if userModel!.hitungscore=="Oily" || userModel2!.hitungscore=="Oily"{
            fotoSkin.image=#imageLiteral(resourceName: "Homepage-oily")
            skinLabel.text="Oily Skin"
        }
        else if userModel!.hitungscore=="Dry" || userModel2!.hitungscore=="Dry"{
            fotoSkin.image=#imageLiteral(resourceName: "Homepage-dry")
            skinLabel.text="Dry Skin"

            
        }
        else if userModel!.hitungscore=="Combination" || userModel2!.hitungscore=="Combination"{
            fotoSkin.image=#imageLiteral(resourceName: "Hompage-combi")
            skinLabel.text="Combination Skin"

        }
        else if userModel!.hitungscore=="Sensitive" || userModel2!.hitungscore=="Sensitive"{
            fotoSkin.image=#imageLiteral(resourceName: "Homepage-sensitive")
            skinLabel.text="Sensitive skin"

        }
       
        // Do any additional setup after loading the view.
        
//        var userData = User.getUserData(viewContext: getViewContext())
//        print(userData)
//        if (userData == nil) {
//            userData = User.saveUserData(viewContext: getViewContext(), userData: UserData(nama: "Feby", ttl: Date(), gender: "F", id: "1", skintype: "oily", allergy: "no"))
//
//            if (userData == nil) {
//                print("SAVE USER GAGAL")
//            } else {
//                print("SAVE USER SUCCESS")
//            }
//        }
    }
//  func goToHomePage() {
//      guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnBoardNinthVC") as? UINavigationController else {
//          return
//      }
//      let navigationController = rootVC
//
//      UIApplication.shared.windows.first?.rootViewController = navigationController
//      UIApplication.shared.windows.first?.makeKeyAndVisible()
//  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

         if segue.identifier == "pictureClicked" {
           _ = segue.destination as! PopOverSkinType
           }



       }
//    func goToHome(){
//        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let loggedInVC = storyboard.instantiateViewController(withIdentifier: "OnBoardNinthVC")
//        loggedInVC.modalPresentationStyle = .fullScreen
//        self.present(loggedInVC, animated: true, completion: nil)
//    }
    
    
 
    func setTodayLabel() {
         let formatter = DateFormatter()
         formatter.timeStyle = .none
         formatter.dateStyle = .full
         dateLabel.text = formatter.string(from: Date())
     }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           print("Homepage will appear")
           loadUser()
           prepareForJournal()
           prepareForChart()
           self.navigationController?.setNavigationBarHidden(true, animated: animated)
       }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Homepage did appear")
    }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.navigationController?.setNavigationBarHidden(false, animated: animated)
       }
    
    func loadUser() {
        //Assume the current user is on the last Core Data
        do {
            let req: NSFetchRequest<User> = User.fetchRequest()
            //Just fetch
            if let user = try ViewModel.globalContext.fetch(req).last {
                self.nameLabel.text = user.nama
                if let currentImg = user.fotoprofil {
                    self.profileAva.setImage(UIImage(data: currentImg), for: .normal)
                    self.profileAva.imageView?.layer.cornerRadius = (self.profileAva.imageView?.frame.width)! / 2.0
                }
            }
        } catch {
            print(error)
        }
    }
    
    func loadExample() {
              let req : NSFetchRequest<User> = User.fetchRequest()
              do {
                  let res = try ViewModel.globalContext.fetch(req)
                userModel = res[0]
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
                   userModel2 = res.last
                      
                      //firstItem.allergy
                      //firstItem.nama
                      
                  } catch {
                      print(error)
                  }
              }
    
    func prepareScreen()  {
        //date label
       
        
//        print(Date())
        
        
        //UIView
        viewSkinCond.layer.cornerRadius = 20
        viewSkinCond.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        //name label
        
    }
    
    @IBAction func onPressedProfileButton(_ sender: UIButton) {
        print("PROFILE")
    }
    
    @IBAction func onPressSkinType(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "pictureClicked", sender: self)
        print("Skin tapped") 
    }
    
    
    @IBAction func onPressedProduct(_ sender: Any) {
        print("PRESS PRODUCT")
        let sb = UIStoryboard(name: "SkinJournalSB", bundle: nil)
        if !journalViewModel.isProductCreated {
            guard let destVC = sb.instantiateViewController(identifier: "AddProduct") as? SkinJournalSecondVC else {fatalError("Error init VC Product")}
            destVC.viewModel = journalViewModel
            self.navigationController?.pushViewController(destVC, animated: true)
        }
    }
    
    @IBAction func onPressedSkinJournal(_ sender: UITapGestureRecognizer) {
        print("PRESS SKIN JOURNAL")
        //Reference to Storyboard
        let sb = UIStoryboard(name: "SkinJournalSB", bundle: nil)
        
        if journalViewModel.isProductCreated {
            //Product already created so
            guard let destVC = sb.instantiateViewController(identifier: "AddJournal") as? SkinJournalThird else {fatalError("Error init VC Journal")}
            destVC.viewModel = journalViewModel
            destVC.index = 0
            //If photo is exist then its editing
            //If dont exist is the otherwise
            if let _ = journalViewModel.allJournalModel[0].photo {
                destVC.isEditingJournal = true
            } else {
                destVC.isEditingJournal = false
            }
            self.navigationController?.pushViewController(destVC, animated: true)
        }
    }
    @IBAction func onPressedViewAllJournal(_ sender: UIButton) {
        print("VIEW ALL")
    }
    
    
    @IBAction func onPressedProgress(_ sender: UITapGestureRecognizer) {
        print("PRESS YOUR PROGRESS")
    }
    
    @IBAction func onPressedHistoryProducts(_ sender: UITapGestureRecognizer) {
        print("PRESS HISTORY PRODUCTS")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
       }
    
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductHistoryCell", for: indexPath) as! ProductHistoryCell
        cell.prodImage.image = UIImage(named: productImages[indexPath.row])
        cell.prodNameLabel.text = productNames[indexPath.row]
        return cell
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(indexPath.row)
        // Lebar & tinggi cell
        return CGSize(width: 125, height: collectionView.frame.height)
        
    }
    
    //MARK: - HomePage Journal
    
    func prepareForJournal() {
        //Prepare Journal
        journalViewModel.createEmptyJournal()
        //When the product is created
        if journalViewModel.isProductCreated {
            //Set the product
            guard let productImgData = journalViewModel.productModel?.foto else {return}
            guard let productName = journalViewModel.productModel?.namaproduk else {return}
            guard let productCategory = journalViewModel.productModel?.kategori else {return}
            
            productHeadLabel.text = productName
            productDescLabel.text = productCategory
            productImageView.image = UIImage(data: productImgData)
            
            
            let currentJournal = journalViewModel.allJournalModel[0]
            //Journal maybe filled
            if let img = currentJournal.photo {
                let durasi = journalViewModel.productModel!.durasi
                journalHeadLabel.text = "Day \(currentJournal.daycount)/ \(durasi)"
                
                journalImageView.image = UIImage(data: img)
                let acneScore = currentJournal.acne
                let wrinkleScore = currentJournal.foreheadwrinkle
                journalDescLabel.text = "Acne: \(String(format: "%.2f", acneScore)) Wrinkle: \(String(format: "%.2f", wrinkleScore))"
            } else {
                //Journal maybe empty
                journalHeadLabel.text = "Add a New Journal"
                journalDescLabel.text = "You haven't write any journal"
                journalImageView.image = UIImage (named: "Home page")
            }
        } else {
            productHeadLabel.text = "Add  a New Product"
            productDescLabel.text = "No product yet"
            productImageView.image = UIImage (named: "plusmerah")
            journalHeadLabel.text = "Can't add journal yet"
            journalHeadLabel.text = "Can't add journal yet"
            journalDescLabel.text = "Add a product first"
            journalImageView.image = UIImage (named: "Home page")
        }
    }
    
    
    func prepareForChart() {
        var acneEntry = [ChartDataEntry]()
        var wrinkleEntry = [ChartDataEntry]()
        
        if journalViewModel.allJournalModel.count >= 2 {
            //Looping over all journal
            //The most recent journal is on the beginning and
            //the later was the older one
            for journal in journalViewModel.allJournalModel {
                //Only filled journal
                if journal.photo != nil {
                    print("Adding")
                    acneEntry.insert(ChartDataEntry(x: Double(journal.daycount), y: journal.acne), at: 0)
                    wrinkleEntry.insert(ChartDataEntry(x: Double(journal.daycount), y: journal.foreheadwrinkle), at: 0)
                }
            }
            
                let acneDS = LineChartDataSet(entries: acneEntry, label: "Acne Score")
                acneDS.colors = [NSUIColor.blue]
                acneDS.circleColors = [NSUIColor.blue]
            
                
                let wrinkeDS = LineChartDataSet(entries: wrinkleEntry, label: "Wrinkle Score")
                wrinkeDS.colors = [NSUIColor.purple]
                wrinkeDS.circleColors = [NSUIColor.purple]
                
                lineChart.data = LineChartData(dataSets: [acneDS,wrinkeDS])
        } else {
            lineChart.data = nil
        }
    }
    
}

extension HomePageFirstVC: ViewModelDelegate {
    func didNeedSync() {
        self.prepareForJournal()
    }
    
    func didNeedChartUpdate() {
        prepareForChart()
    }
    
}


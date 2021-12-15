//
//  cameraViewController.swift
//  real-life-locations
//
//  Created by 笹倉一也 on 2021/12/12.
//

import UIKit
import Firebase
import DKImagePickerController

class cameraViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var photos: [UIImage] = []
    var selectedCount = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        let nib = UINib(nibName: "cameraCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        openLibrary()
        
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
//        let db = Firestore.firestore()
//        let user = Auth.auth().currentUser
//
//        db.collection("users").document(user!.uid).collection("posts").document().setData([
//            "title":
//
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
        
    }
    
    @IBAction func libraryBtn(_ sender: Any) {
        
        openLibrary()
        
    }
    
    func reloadImage() {
         // photos.count と asset.count が等しければ tableView を再描画
         if photos.count == selectedCount {
             collectionView.reloadData()
         }
     }
    
    @IBAction func nextBtn(_ sender: Any) {
        

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! cameraCollectionViewCell
        
        cell.photoImage.image = photos[indexPath.row]
             
        return cell
        
    }
    
    func openLibrary() {
        
        let imagePicker = DKImagePickerController()
        imagePicker.maxSelectableCount = 6

        imagePicker.sourceType = .photo

        imagePicker.showsCancelButton = true

        imagePicker.didSelectAssets = { (assets: [DKAsset]) in
               // ここでは一旦全削除する
        self.photos.removeAll()

               // assets に保存された枚数
        self.selectedCount = assets.count

        for asset in assets {
                
            asset.fetchFullScreenImage(completeBlock: { (image, info) in
                       // もし image が nil だったら早期リターン
                guard let image = image else {
                    self.selectedCount -= 1
                    return
                }

                // photos に追加
                self.photos.append(image)

                
                print(self.photos)
                // reloadImage 内部で UITableView を操作しているため
                // メインスレッドで実行
                DispatchQueue.main.async {
                    self.reloadImage()
                }
            })
        }
    }

        // ここでDKImagePickerを表示
        present(imagePicker, animated: true, completion: nil)
     
    }
    
        
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
          if segue.identifier == "goMapView" {
   
              let nextView = segue.destination as! mapViewController
   
//              nextView.animeTitle = inputTitleTF.text!
          }
      }


}

//
//  mapViewController.swift
//  real-life-locations
//
//  Created by 笹倉一也 on 2021/12/12.
//

import UIKit
import Firebase

class mapViewController: UIViewController {

    var animeTitle = ""
    var titlename = ""
    var postImages: [UIImage] = []
    var imageNames = [String]()
    var urls = [String]()
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var shareImage: UIImageView!
    @IBOutlet weak var titlenameTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("test\(postImages)")
        
//        label.text = animeTitle
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func shareBtn(_ sender: Any) {
        
//        tag,images,imagesname,place,
        
            let user = Auth.auth().currentUser
            
            var count = 0
            self.titlename = self.titlenameTF.text!
            
        for image in postImages {

            
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"

            let imageName = NSUUID().uuidString // Unique string to reference image
            let storageRef = Storage.storage().reference().child("posts").child(user!.uid).child(titlename).child(imageName)
                
            guard let data = image.jpegData(compressionQuality: 0.1) else {return}
                 storageRef.putData(data, metadata: metaData) { (metadata, error) in
                     if error != nil {
                         return
                     }
                     storageRef.downloadURL(completion: { [self] (url, error) in
                         if let photoUrl = url?.absoluteString {
                             let url = photoUrl

                             self.urls.append(url)

                             let db = Firestore.firestore()

                             self.imageNames.append(imageName)
                             
//                             self.titlename = self.titlenameTF.text!


                             let Ref = db.collection("users").document(user!.uid).collection("posts")

                             let aDoc = Ref.document()

                             print(aDoc.documentID)

                             let someData = [
                                "imageurls": self.urls,
                                "title" : self.titlename,
                                "imageNames": self.imageNames,
                                "documentID":aDoc.documentID
                             ] as [String : Any]

                             Ref.document(self.titlename).setData(someData)

                                {
                                 err in
                                 if let err = err {
                                     print("Error writing document: \(err)")
                                         } else {
                                             print("Document successfully written!")
                                            }
                                    }
                                             }
                                             
                                             
                                             
                         

                         count += 1
                         if count == self.postImages.count {
                             print("self.urls.count \(self.urls.count)")


                         }
                     })
                 }

             }
        
  
        

            self.navigationController?.popToRootViewController(animated: true)
        
    }
    

}

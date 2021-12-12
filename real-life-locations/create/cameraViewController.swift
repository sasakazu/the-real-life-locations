//
//  cameraViewController.swift
//  real-life-locations
//
//  Created by 笹倉一也 on 2021/12/12.
//

import UIKit
import Firebase

class cameraViewController: UIViewController {

    
    @IBOutlet weak var inputTitleTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveBtn(_ sender: Any) {
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        db.collection("users").document(user!.uid).collection("posts").document().setData([
            "title": inputTitleTF.text
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    

    @IBAction func nextBtn(_ sender: Any) {
        

    }
    
        
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
          if segue.identifier == "goMapView" {
   
              let nextView = segue.destination as! mapViewController
   
              nextView.animeTitle = inputTitleTF.text!
          }
      }


}

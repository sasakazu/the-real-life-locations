//
//  signup.swift
//  real-life-locations
//
//  Created by 笹倉一也 on 2021/12/10.
//

import UIKit
import Firebase


class signup: UIViewController {

    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signup(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: email.text!, password: pass.text!) { authResult, error in
          
            
            print("sign up!")
            
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            
            let id = user?.uid
                
            db.collection("users").document(id!).setData([
                "email": self.email.text ?? "no email",
                "userID": user?.uid ?? "no id"
            
            ], merge: true)
            }
            
            
        }
    
    
    
    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do {
              try firebaseAuth.signOut()
            print("sign out done.")
        
        } catch let signOutError as NSError {
            
            print("Error signing out: %@", signOutError)
        
        }
      
        
    }
    
    

}

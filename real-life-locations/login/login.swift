//
//  login.swift
//  real-life-locations
//
//  Created by 笹倉一也 on 2021/12/10.
//

import UIKit
import Firebase

class login: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginBtn(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTF.text!, password: passTF.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          // ...
        
        
        }
        
        
    }
    
    
}

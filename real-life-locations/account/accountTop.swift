//
//  accountTop.swift
//  real-life-locations
//
//  Created by 笹倉一也 on 2021/12/11.
//

import UIKit
import Firebase

class accountTop: UIViewController {

    
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        
        userLabel.text = user?.email

        // Do any additional setup after loading the view.
    }
    



}

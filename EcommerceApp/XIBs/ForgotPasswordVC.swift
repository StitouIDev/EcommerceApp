//
//  ForgotPasswordVC.swift
//  Artable
//
//  Created by Hamza on 2/2/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {
    
    
    // Outlets
    @IBOutlet weak var emailTxt: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetClicked(_ sender: Any) {
        guard let email = emailTxt.text , email.isNotEmpty else {
            simpleAlert(title: "Error", msg: "Please Enter email.")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}

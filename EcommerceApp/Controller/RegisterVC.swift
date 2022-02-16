//
//  RegisterVC.swift
//  Artable
//
//  Created by Hamza on 1/31/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passChekImg: UIImageView!
    @IBOutlet weak var confirmCheckImg: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        passwordTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPassTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        // Do any additional setup after loading the view.

    }
    
   
    @objc func textFieldDidChange(_ textField: UITextField){
        guard let passTxt = passwordTxt.text else { return }
        
        if textField == confirmPassTxt {
            passChekImg.isHidden = false
            confirmCheckImg.isHidden = false
        }
        
        if passTxt.isEmpty {
            passChekImg.isHidden = true
            confirmCheckImg.isHidden = true
            confirmPassTxt.text = ""
        }
        
        // Make it so when the passwords match, the checkmarks turn green.
        if passwordTxt.text == confirmPassTxt.text {
            passChekImg.image = UIImage(named: AppImages.GreenChek)
            confirmCheckImg.image = UIImage(named: AppImages.GreenChek)
        } else {
            passChekImg.image = UIImage(named: AppImages.RedChek)
            confirmCheckImg.image = UIImage(named: AppImages.RedChek)
        }
    }

 
    @IBAction func registerClicked(_ sender: Any) {
        guard let email = emailTxt.text , email.isNotEmpty ,
            let username = usernameTxt.text , username.isNotEmpty ,
            let password = passwordTxt.text , password.isNotEmpty  else {
                simpleAlert(title: "Error", msg: "Please fill out all fields.")
                return
                
        }
        
        guard let confirmPass = confirmPassTxt.text , confirmPass == password else {
            simpleAlert(title: "Error", msg: "Passwords do not match.")
            return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            }
            
            guard let firUser = result?.user else { return }
            let artUser = User.init(id: firUser.uid, email: email, username: username)
            
            // Upload to Firestore
            self.createFirestoreUser(user: artUser)
            
        }
        
    }
    
    func createFirestoreUser(user: User) {
        // Step 1: Create document reference
        let newUserRef = Firestore.firestore().collection("users").document(user.id)
        
        // Step 2: Create model Data
        let data = User.modelToData(user: user)

        // Step 3: Upload to Firestore
        newUserRef.setData(data) { (error) in
            if let error = error {
                Auth.auth().handleFireAuthError(error: error, vc: self)
                debugPrint("Error signing in: \(error.localizedDescription) ")
            } else {
                self.dismiss(animated: true, completion: nil)
                self.activityIndicator.stopAnimating()
            }
        }
        
    }
    
}

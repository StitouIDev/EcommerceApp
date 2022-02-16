//
//  Extensions.swift
//  Artable
//
//  Created by Hamza on 1/31/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import Foundation
import UIKit
import Firebase


extension String {
    var isNotEmpty : Bool {
        return !isEmpty 
    }
    
}

extension UIViewController {
    func simpleAlert(title: String, msg : String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension Int {
    
    func convertCurrency() -> String {
        let dollars = Double(self) / 100
        let formatter = NumberFormatter()
        formatter.numberStyle = . currency
        
        if let dollarString = formatter.string(from: dollars as NSNumber) {
            return dollarString
        }
        return "$0.00"
    }
}


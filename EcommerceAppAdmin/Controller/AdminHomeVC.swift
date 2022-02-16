//
//  ViewController.swift
//  ArtableAdmin
//
//  Created by Hamza on 1/7/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import UIKit

class AdminHomeVC: HomeVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem?.isEnabled = false
        
        let addCategoryBtn = UIBarButtonItem(title: "Add Category", style: .plain, target: self, action: #selector(addCategory))
        navigationItem.rightBarButtonItem = addCategoryBtn
    }


    @objc func addCategory() {
        performSegue(withIdentifier: Segues.ToAddEditCategory, sender: self)
    }
    
}


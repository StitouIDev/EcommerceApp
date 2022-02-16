//
//  AddEditProductsVC.swift
//  ArtableAdmin
//
//  Created by Hamza on 2/7/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class AddEditProductsVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var productNameTxt: UITextField!
    @IBOutlet weak var productPriceTxt: UITextField!
    @IBOutlet weak var productDecTxt: UITextView!
    @IBOutlet weak var productImgView: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addBtn: RoundedButton!
    
    
    var productToEdit: Product?
    var selectedCategory: Category!
    var productName = ""
    var price = 0.0
    var productDescription = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped(_:)))
        tap.numberOfTapsRequired = 1
        productImgView.isUserInteractionEnabled = true
        productImgView.clipsToBounds = true
        productImgView.addGestureRecognizer(tap)
        
        
        if let product = productToEdit {
            productNameTxt.text = product.name
            productPriceTxt.text = String(product.price)
            productDecTxt.text = product.productDescription
            addBtn.setTitle("Save Changes", for: .normal)
            
            if let url = URL(string: product.imageUrl) {
                productImgView.contentMode = .scaleAspectFill
                productImgView.kf.setImage(with: url)
            }
        }

    }
    

    @objc func imgTapped(_ tap: UITapGestureRecognizer) {
        launchImgPicker()
    }
    
    @IBAction func AddBtnClicked(_ sender: Any) {
        activityIndicator.startAnimating()
        uploadImageThenDocument()
    }
    
    func uploadImageThenDocument() {
        
        guard let image = productImgView.image , let productName = productNameTxt.text , productName.isNotEmpty ,
             let description = productDecTxt.text , description.isNotEmpty,
             let priceString = productPriceTxt.text, priceString.isNotEmpty,
             let price = Double(priceString)
        else {
            simpleAlert(title: "Missing Fields", msg: "Please fill out all required field.")
            return
        }
        self.productName = productName
        self.productDescription = description
        self.price = price
        
        activityIndicator.startAnimating()

        
        // Step 1: Turn the image into Data
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        // Step 2: Create an storage image reference -> A location in Firestorage for it to be stored.
        let imageRef = Storage.storage().reference().child("/productImages/\(productName).jpg")
        
        // Step 3: Set the meta Data
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        // Step 4: Upload the data
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            
            
            if let error = error {
                self.handleError(error: error, msg: "Unable to upload image.")
                return
            }
            
            // Step 5: Once the image is uploaded retrieve the download URL
            imageRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    self.handleError(error: error, msg: "Unable to download url.")
                    return
                }
                
                guard let url = url else { return }
                print(url)
                
                
                // Step 6: Upload new Category document to the Firestore categories collection
                
                self.uploadDocument(url: url.absoluteString)
                
            })
        }
    }
    
    func uploadDocument(url: String) {
        var docRef: DocumentReference!
        var product = Product.init(name: productName,
                                   id: "",
                                   category: selectedCategory.id,
                                   price: price,
                                   productDescription: productDescription,
                                   imageUrl: url)
        
        
        if let producToEdit = productToEdit {
            // We are editing
            docRef = Firestore.firestore().collection("products").document(producToEdit.id)
            product.id = producToEdit.id
        } else {
            // New Category
            docRef = Firestore.firestore().collection("products").document()
            product.id = docRef.documentID
        }
        
        
        
        let data = Product.modelToData(product: product)
        
        docRef.setData(data, merge: true) { (error) in
            if let error = error {
                self.handleError(error: error, msg: "Unable to upload new product to Firestore")
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func handleError(error: Error, msg: String){
        debugPrint(error.localizedDescription)
        self.simpleAlert(title: "Error", msg: msg)
        self.activityIndicator.stopAnimating()
    }
    

}


extension AddEditProductsVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func launchImgPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        productImgView.contentMode = .scaleAspectFill
        productImgView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

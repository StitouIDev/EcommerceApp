//
//  ProductCell.swift
//  Artable
//
//  Created by Hamza on 2/3/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import UIKit
import Kingfisher


protocol ProductCellDelegate : class {
    func productFavorited(product: Product)
    func productAddCart(product: Product)
}

class ProductCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var productImg: RoundedImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    weak var delegate : ProductCellDelegate?
    private var product: Product!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(product: Product, delegate: ProductCellDelegate){
        self.product = product
        self.delegate = delegate
        
        productTitle.text = product.name
        if let url = URL(string: product.imageUrl) {
            let placeholder = UIImage(named: AppImages.Placeholder)
            productImg.kf.indicatorType = .activity
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.2))]
            productImg.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            productPrice.text = price
        }
        
        if UserService.favorites.contains(product) {
            favoriteBtn.setImage(UIImage(named: AppImages.FilledStar), for: .normal)
        } else {
            favoriteBtn.setImage(UIImage(named: AppImages.EmptyStar), for: .normal)
        }
        
        
    }

   
    @IBAction func addToCartClicked(_ sender: Any) {
    
        delegate?.productAddCart(product: product)
    }
    
    @IBAction func favoriteClicked(_ sender: Any) {
    
        delegate?.productFavorited(product: product)
    }
    
}

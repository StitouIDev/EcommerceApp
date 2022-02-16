//
//  CheckoutVC.swift
//  Artable
//
//  Created by Hamza on 2/11/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController, CartItemDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var feeLbl: UILabel!
    @IBOutlet weak var shippingLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var paymentMethodBtn: UIButton!
    @IBOutlet weak var shippingMethodBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.CartItemCell, bundle: nil), forCellReuseIdentifier: Identifiers.CartItemCell)
        
        setupPayment()
        
    }
    

    func setupPayment() {
        subTotalLbl.text = BankCart.subtotal.convertCurrency()
        feeLbl.text = BankCart.procFees.convertCurrency()
        shippingLbl.text = BankCart.shippingFees.convertCurrency()
        totalLbl.text = BankCart.total.convertCurrency()
    }
    
    @IBAction func placeOrderClicked(_ sender: Any) {
    }
    
    @IBAction func paymentMethodClicked(_ sender: Any) {
    }
    
    @IBAction func shippingMethodClicked(_ sender: Any) {
    }
    
    func removeItem(product: Product) {
        BankCart.removefromCart(item: product)
        tableView.reloadData()
        setupPayment()
    }
    
    
}

extension CheckoutVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BankCart.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.CartItemCell, for: indexPath) as? CartItemCell {
            let product = BankCart.cartItems[indexPath.row]
            cell.configCell(product: product, delegate: self)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

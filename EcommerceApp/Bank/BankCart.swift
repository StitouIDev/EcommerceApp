//
//  BankCart.swift
//  Artable
//
//  Created by Hamza on 2/12/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import Foundation


let BankCart = _BankCart()

final class _BankCart {
    var cartItems = [Product]()
    private let CardCut = 0.020
    private let FeeCents = 30
    var shippingFees = 0
    
    // variables for subtotal, processing fees, total
    
    var subtotal : Int {
        var amount = 0
        for item in cartItems {
            let priceP = Int(item.price * 100)
            amount += priceP
        }
        return amount
    }
    
    var procFees : Int {
        
        if subtotal == 0 { return 0 }
        
        let sub = Double(subtotal)
        let feesAndSub = Int(sub * CardCut) + FeeCents
        return feesAndSub
    }
    
    var total : Int {
        return subtotal + procFees + shippingFees
    }
    
    func addToCart(item: Product) {
        cartItems.append(item)
    }
    
    func removefromCart(item: Product) {
        if let index = cartItems.firstIndex(of: item) {
            cartItems.remove(at: index)
        }
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}

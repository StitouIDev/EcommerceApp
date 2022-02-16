//
//  Constants.swift
//  Artable
//
//  Created by Hamza on 1/31/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import Foundation
import UIKit


struct Storyboard {
    static let LoginStoryboard = "LoginStoryboard"
    static let Main = "Main"
}

struct StoryboardId {
    static let LoginVC = "loginVC"
}

struct AppImages {
    static let GreenChek = "green_check"
    static let RedChek = "red_check"
    static let FilledStar = "filled_star"
    static let EmptyStar = "empty_star"
    static let Placeholder = "placeholder"
    
}

struct AppColors {
    static let Blue = #colorLiteral(red: 0.2914361954, green: 0.3395442367, blue: 0.4364506006, alpha: 1)
    static let Red = #colorLiteral(red: 0.8739202619, green: 0.4776076674, blue: 0.385545969, alpha: 1)
    static let OffWhite = #colorLiteral(red: 0.9626371264, green: 0.959995091, blue: 0.9751287103, alpha: 1)
}

struct Identifiers {
    static let CategoryCell = "CategoryCell"
    static let ProductCell = "ProductCell"
    static let CartItemCell = "CartItemCell"
}

struct Segues {
    static let toProducts = "toProductsVC"
    static let ToAddEditCategory = "ToAddEditCategory"
    static let ToEditCategory = "ToEditCategory"
    static let ToAddEditProduct = "ToAddEditProduct"
    static let ToFavorites = "ToFavorites"
}

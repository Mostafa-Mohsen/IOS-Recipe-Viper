//
//  DetailsViewModels.swift
//  Recipe
//
//  Created by Soft Xpert on 9/10/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation

protocol Identity {
    var identifier: String { get }
}

struct DetailsImageViewModel:Identity {
    let identifier = "imageCell"
    let imageUri:String
}

struct DetailsTitleViewModel:Identity {
    let identifier = "titleCell"
    let title:String
}

struct DetailsIngredientsTitleViewModel:Identity {
    let identifier = "ingredientTitleCell"
    let title:String = "Ingrediens"
}

struct DetailsIngredientsViewModel:Identity {
    let identifier = "ingredientsCell"
    let ingredient:String
}

struct DetailsLinkViewModel:Identity {
    let identifier = "linkCell"
    let link:String
}

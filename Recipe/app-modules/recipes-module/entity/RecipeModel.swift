//
//  RecipeModel.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import ObjectMapper

struct RecipeViewModel{
    static let URI = "recipe.uri"
    static let LABEL = "recipe.label"
    static let IMAGE = "recipe.image"
    static let SOURCE = "recipe.source"
    static let HEALTHLABELS = "recipe.healthLabels"
    static let INGREDIENTLINES = "recipe.ingredientLines"
}

class RecipeModel: Mappable{
    
    internal var uri:String?
    internal var label:String?
    internal var image:String?
    internal var source:String?
    internal var healthLabels:Array<String>?
    internal var ingredientLines:Array<String>?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        uri <- map[RecipeViewModel.URI]
        label <- map[RecipeViewModel.LABEL]
        image <- map[RecipeViewModel.IMAGE]
        source <- map[RecipeViewModel.SOURCE]
        healthLabels <- map[RecipeViewModel.HEALTHLABELS]
        ingredientLines <- map[RecipeViewModel.INGREDIENTLINES]
    }
}

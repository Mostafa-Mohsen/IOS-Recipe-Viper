//
//  RecipeModel.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import ObjectMapper

private let LABEL = "recipe.label"
private let IMAGE = "recipe.image"
private let SOURCE = "recipe.source"
private let HEALTHLABELS = "recipe.healthLabels"
private let RECIPE = "recipe"
private let INGREDIENTLINES = "ingredientLines"

class RecipeModel: Mappable{
    
    internal var label:String?
    internal var image:String?
    internal var source:String?
    internal var healthLabels:Array<String>?
    internal var ingredientLines:String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        label <- map[LABEL]
        image <- map[IMAGE]
        source <- map[SOURCE]
        healthLabels <- map[HEALTHLABELS]
        ingredientLines <- map[INGREDIENTLINES]
    }
}

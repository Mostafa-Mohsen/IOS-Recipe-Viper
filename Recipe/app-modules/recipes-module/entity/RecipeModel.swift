//
//  RecipeModel.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import ObjectMapper

private let URI = "recipe.uri"
private let LABEL = "recipe.label"
private let IMAGE = "recipe.image"
private let SOURCE = "recipe.source"
private let HEALTHLABELS = "recipe.healthLabels"
private let INGREDIENTLINES = "recipe.ingredientLines"

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
        uri <- map[URI]
        label <- map[LABEL]
        image <- map[IMAGE]
        source <- map[SOURCE]
        healthLabels <- map[HEALTHLABELS]
        ingredientLines <- map[INGREDIENTLINES]
    }
}

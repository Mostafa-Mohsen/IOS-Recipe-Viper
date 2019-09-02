//
//  RecipeInteractor.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import ObjectMapper

class RecipesInteractor: PresenterToInteractorProtocol{
    
    var presenter: InteractorToPresenterProtocol?
    
    func fetchRecipes() {
        NetworkManager.connectGetToUrl(url: "https://api.edamam.com/search?q=cake&app_id=9b3da956&app_key=5e85e075822a1368b9efafa387a149eb&from=0&to=20", serviceProtocol: self)
    }
}

extension RecipesInteractor: NetworkObserver{
    func recipesFetchsuccess(data: AnyObject) {
        let arrayResponse = data["hits"] as! NSArray
        let arrayObject = Mapper<RecipeModel>().mapArray(JSONArray: arrayResponse as! [[String : Any]]);
        presenter?.recipesFetchsuccess(recipesModelArray: arrayObject)
    }
    
    func recipesFetchfailed(message:String) {
        presenter?.recipesFetchfailed(message: message)
    }
    
}

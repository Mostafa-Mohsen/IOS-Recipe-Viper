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
    var more = false
    var page = 1
    var searchRecipe: String?
    
    func fetchRecipes(searchText:String) {
        presenter?.showLoading()
        searchRecipe = searchText
        page = 1

        NetworkManager.connectGetToUrl(url: "https://api.edamam.com/search?q=\(searchText)&app_id=9b3da956&app_key=5e85e075822a1368b9efafa387a149eb&from=\(page*20 - 20)&to=\(page*20)", networkObserver: self)
    }
    
    func loadMorerRecipes() {
        if more && page < 6{
            NetworkManager.connectGetToUrl(url: "https://api.edamam.com/search?q=\(searchRecipe!)&app_id=9b3da956&app_key=5e85e075822a1368b9efafa387a149eb&from=\(page*20 - 20)&to=\(page*20)", networkObserver: self)
        }
    }
    
}

extension RecipesInteractor: NetworkObserver{
    func recipesFetchsuccess(data: AnyObject) {
        page += 1
        let arrayResponse = data["hits"] as! NSArray
        more = data["more"] as! Bool
        let arrayObject = Mapper<RecipeModel>().mapArray(JSONArray: arrayResponse as! [[String : Any]]);
        
        if page == 2 {
            presenter?.hideLoading()
        }
        
        presenter?.recipesFetchsuccess(recipesModelArray: arrayObject)
    }
    
    func recipesFetchfailed(message:String) {
        presenter?.recipesFetchfailed(message: message)
    }
    
}

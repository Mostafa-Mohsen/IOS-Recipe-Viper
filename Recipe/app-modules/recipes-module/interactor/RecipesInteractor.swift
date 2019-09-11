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
    
    weak var presenter: InteractorToPresenterProtocol?
    var more = false
    var page = 1
    var searchRecipe: String = ""
    
    func fetchRecipes(searchText:String) {
        presenter?.showLoading()
        searchRecipe = searchText
        page = 1

        let parametrs = [
            "q" : searchText,
            "app_id" : Constents.APP_ID,
            "app_key" : Constents.APP_KEY,
            "from" : "\(page*20 - 20)",
            "to" : "\(page*20)"
        ]
        NetworkManager.connectGetToUrl(parametrs: parametrs, networkObserver: self)
        
    }
    
    func loadMorerRecipes() {
        if more && page < 6{
            let parametrs = [
                "q" : searchRecipe,
                "app_id" : Constents.APP_ID,
                "app_key" : Constents.APP_KEY,
                "from" : "\(page*20 - 20)",
                "to" : "\(page*20)"
            ]
            NetworkManager.connectGetToUrl(parametrs: parametrs, networkObserver: self)
            
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

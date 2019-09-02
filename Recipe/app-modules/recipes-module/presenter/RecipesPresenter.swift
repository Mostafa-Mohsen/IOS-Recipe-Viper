//
//  RecipesPresenter.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import UIKit

class RecipesPresenter:ViewToPresenterProtocol{
    
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func startFetchingRecipes() {
        interactor?.fetchRecipes()
    }
    func showDetailsController(navigationController:UINavigationController,recipe: RecipeModel) {
        router?.pushToMovieScreen(navigationConroller: navigationController, recipe: recipe)
    }
}

extension RecipesPresenter: InteractorToPresenterProtocol{
    func recipesFetchsuccess(recipesModelArray: Array<RecipeModel>) {
        view?.showRecipes(recipesArray: recipesModelArray)
    }
    
    func recipesFetchfailed(message:String) {
        view?.showError(message: message)
    }
}

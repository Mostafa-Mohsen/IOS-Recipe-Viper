//
//  RecipesProtocol.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class{
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    
    func startFetchingRecipes()
    func showDetailsController(navigationController:UINavigationController,recipe: RecipeModel)
}

protocol PresenterToViewProtocol: class{
    func showRecipes(recipesArray:Array<RecipeModel>)
    func showError(message:String)
}

protocol PresenterToRouterProtocol: class {
    static func createModule() -> RecipesViewController
    func pushToMovieScreen(navigationConroller:UINavigationController,recipe: RecipeModel)
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? {get set}
    func fetchRecipes()
}

protocol InteractorToPresenterProtocol: class {
    func recipesFetchsuccess(recipesModelArray:Array<RecipeModel>)
    func recipesFetchfailed(message:String)
}

protocol NetworkObserver: class{
    func recipesFetchsuccess(data:AnyObject)
    func recipesFetchfailed(message:String)
}


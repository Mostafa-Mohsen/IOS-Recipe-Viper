//
//  RecipesRouter.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import UIKit

class RecipesRouter:PresenterToRouterProtocol{
    
    static func createModule() -> RecipesViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "RecipesViewController") as! RecipesViewController
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = RecipesPresenter()
        let interactor: PresenterToInteractorProtocol = RecipesInteractor()
        let router: PresenterToRouterProtocol = RecipesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}

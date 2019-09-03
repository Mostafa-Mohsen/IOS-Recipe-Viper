//
//  SearchRouter.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import UIKit

class SearchRouter: SearchPresenterToRouterProtocol {
    
    static func createModule() -> SearchTableViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "searchTable") as! SearchTableViewController
        let presenter: SearchViewToPresenterProtocol & SearchInteractorToPresenterProtocol = SearchPresenter()
        let interactor: SearchPresenterToInteractorProtocol = SearchInteractor()
        let router: SearchPresenterToRouterProtocol = SearchRouter()
        
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

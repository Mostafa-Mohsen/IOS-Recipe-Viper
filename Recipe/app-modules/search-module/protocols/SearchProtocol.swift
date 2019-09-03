//
//  SearchProtocol.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import UIKit

protocol SearchViewToPresenterProtocol: class{
    var view: SearchPresenterToViewProtocol? {get set}
    var interactor: SearchPresenterToInteractorProtocol? {get set}
    var router: SearchPresenterToRouterProtocol? {get set}
    
    func searchBarSearchButtonClicked(searchText: String?)
    func getSuggestions()
    func searchTextDidChange(search:String)
}

protocol SearchPresenterToViewProtocol: class{
    func searchfor(searchText: String)
    func showHistory(searchHistory:[SearchModel])
}

protocol SearchPresenterToRouterProtocol: class {
    static func createModule() -> SearchTableViewController
}

protocol SearchPresenterToInteractorProtocol: class {
    var presenter: SearchInteractorToPresenterProtocol? {get set}
    
    func searchBarSearchButtonClicked(searchText: String?)
    func getSuggestion()
    func searchTextDidChange(search:String)
}

protocol SearchInteractorToPresenterProtocol: class {
    func searchfor(searchText: String)
    
    func handleSuccessWithRealm(searchHistory:[SearchModel])
}

protocol RealmObserver {
    func handleSuccessWithRealm(searchHistory:[SearchModel])
}

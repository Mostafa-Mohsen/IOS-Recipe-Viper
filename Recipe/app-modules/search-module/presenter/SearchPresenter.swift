//
//  SearchPresenter.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import UIKit

class SearchPresenter: SearchViewToPresenterProtocol {
    var view: SearchPresenterToViewProtocol?
    var interactor: SearchPresenterToInteractorProtocol?
    var router: SearchPresenterToRouterProtocol?
    
    func searchBarSearchButtonClicked(searchText: String?){
         interactor?.searchBarSearchButtonClicked(searchText: searchText)
    }
    
    func getSuggestions() {
        interactor?.getSuggestion()
    }
    
    func searchTextDidChange(search: String) {
        interactor?.searchTextDidChange(search: search)
    }
}

extension SearchPresenter: SearchInteractorToPresenterProtocol{
    func searchfor(searchText: String) {
        view?.searchfor(searchText: searchText)
    }
    
    func handleSuccessWithRealm(searchHistory: [SearchModel]) {
        view?.showHistory(searchHistory: searchHistory)
    }
}

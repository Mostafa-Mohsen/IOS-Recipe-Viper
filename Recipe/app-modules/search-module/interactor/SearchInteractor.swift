//
//  SearchInteractor.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
class SearchInteractor: SearchPresenterToInteractorProtocol {
    var presenter: SearchInteractorToPresenterProtocol?
    var historyList: [SearchModel]?
    
    func searchBarSearchButtonClicked(searchText: String?) {
        if let search = searchText {
            RealmManager.saveToRealm(searchText: search)
            let filtered = search.replacingOccurrences(of: " ", with: "")
            presenter?.searchfor(searchText: filtered)
        }
    }
    
    func getSuggestion() {
        RealmManager.readFromRealm(realmObserver: self)
    }
    
    func searchTextDidChange(search: String) {
        if search == "" {
            presenter?.handleSuccessWithRealm(searchHistory: historyList!)
        }else{
            let filteredList = historyList!.filter{$0.search.contains("\(search)")}
            presenter?.handleSuccessWithRealm(searchHistory: filteredList)
        }
    }
}

extension SearchInteractor: RealmObserver{
    func handleSuccessWithRealm(searchHistory: [SearchModel]) {
        historyList = searchHistory
        presenter?.handleSuccessWithRealm(searchHistory: searchHistory)
    }
}

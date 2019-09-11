//
//  SearchTableViewController.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    var presenter: SearchViewToPresenterProtocol?
    var recipesDelegate:recipesSearchDelegate?
    
    var historyList = Array<SearchModel>()
    var searchBarInSearchView :UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getSuggestions()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = historyList[indexPath.row].search
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBarInSearchView?.text = historyList[indexPath.row].search
        self.searchBarSearchButtonClicked(searchBarInSearchView!)
    }

}

extension SearchTableViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            searchController.searchResultsController?.view.isHidden = false
        }
    }
}

extension SearchTableViewController:UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarInSearchView = searchBar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchBarSearchButtonClicked(searchText: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchTextDidChange(search: searchText)
    }
    
}

extension SearchTableViewController:SearchPresenterToViewProtocol{
    func searchfor(searchText: String) {
        recipesDelegate?.searchfor(searchText: searchText)
    }
    
    func showHistory(searchHistory: [SearchModel]) {
        historyList = searchHistory
        tableView.reloadData()
    }
}

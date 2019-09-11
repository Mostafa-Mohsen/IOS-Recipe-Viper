//
//  RecipesViewController.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

class RecipesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchControllerContainer: UIView!
    @IBOutlet weak var notesLabel: UILabel!
    
    var searchController: UISearchController?
    var presenter:ViewToPresenterProtocol?
    var activityIndicator:NVActivityIndicatorView?
    var waiting:UILabel?
    
    var recipes:[RecipeModel] = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchTable = SearchRouter.createModule()
        searchTable.recipesDelegate = self
        searchController = UISearchController(searchResultsController: searchTable)
        searchController?.searchResultsUpdater = searchTable
        searchControllerContainer.addSubview(searchController!.searchBar)
        searchController?.searchBar.delegate = searchTable
        searchController?.searchBar.barTintColor = UIColor.black
        searchController?.hidesNavigationBarDuringPresentation = false
    }
}

extension RecipesViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! RecipesTableViewCell
        cell.recipeLabel.text = recipes[indexPath.row].label
        cell.recipeSource.text = recipes[indexPath.row].source
        cell.recipeHealthLabels.text = (recipes[indexPath.row].healthLabels)?.joined(separator: "-")
        cell.recipeImage.sd_setImage(with: URL(string: recipes[indexPath.row].image!), placeholderImage: UIImage(named: "placeHolder"))
        
        if indexPath.row == recipes.count-5 {
            presenter?.loadMorerRecipes()
        }
        
        return cell
    }
}

extension RecipesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetailsController(recipe: recipes[indexPath.row])
    }
    
    func showDetailsController(recipe: RecipeModel) {
        presenter?.showDetailsController(navigationController: navigationController!, recipe: recipe)
    }
}


extension RecipesViewController:PresenterToViewProtocol{
    
    func showRecipes(recipesArray: Array<RecipeModel>) {
        recipes = recipes + recipesArray
        if recipes.count == 0 {
            tableView.isHidden = true
            notesLabel.isHidden = false
            notesLabel.text = AppStrings.NO_RESULTS_FOUND
        }
        tableView.reloadData()
    }
    
    func showError(message:String) {
        let alert = UIAlertController(title: AppStrings.ERROR, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: AppStrings.OK, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        recipes = Array()
        self.tableView.reloadData()
        self.tableView.isHidden = true
        
        if !notesLabel.isHidden {
            notesLabel.isHidden = true
        }
        addActivityIndicator()
        addWaitingLabel()
    }
    
    func addActivityIndicator() {
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        activityIndicator?.color = UIColor.white
        activityIndicator?.type = .pacman
        activityIndicator?.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        view.addSubview(activityIndicator!)
        activityIndicator?.startAnimating()
    }
    
    func addWaitingLabel(){
        waiting = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150.0, height: 40.0))
        waiting?.text = AppStrings.GETTING_RECIPES
        waiting?.textColor = UIColor.white
        waiting?.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2 + 100)
        view.addSubview(waiting!)
    }
    
    func hideLoading() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        waiting?.removeFromSuperview()
        self.tableView.isHidden = false
    }
    
}

extension RecipesViewController:recipesSearchDelegate{
    func searchfor(searchText: String) {
        searchController?.isActive = false
        presenter?.fetchRecipes(searchText: searchText)
    }
    
    
}

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

class RecipesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
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
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        let searchTable = SearchRouter.createModule()
        searchTable.recipesDelegate = self
        searchController = UISearchController(searchResultsController: searchTable)
        searchController?.searchResultsUpdater = searchTable
        searchControllerContainer.addSubview(searchController!.searchBar)
        searchController?.searchBar.delegate = searchTable
        searchController?.searchBar.barTintColor = UIColor.black
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetailsController(recipe: recipes[indexPath.row])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            notesLabel.text = "No results found for this search"
        }
        tableView.reloadData()
    }
    
    func showError(message:String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        print("show loading")
        recipes = Array()
        self.tableView.reloadData()
        self.tableView.isHidden = true
        
        if !notesLabel.isHidden {
            notesLabel.isHidden = true
        }
        
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        activityIndicator?.color = UIColor.white
        activityIndicator?.type = .pacman
        activityIndicator?.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        view.addSubview(activityIndicator!)
        activityIndicator?.startAnimating()
        
        waiting = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 150.0, height: 40.0))
        waiting?.text = "Getting Recipes..."
        waiting?.textColor = UIColor.white
        waiting?.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2 + 100)
        view.addSubview(waiting!)
    }
    
    func hideLoading() {
        print("hide loading")
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        waiting?.removeFromSuperview()
        self.tableView.isHidden = false
    }
    
}

extension RecipesViewController:recipesSearchDelegate{
    func searchfor(searchText: String) {
        print(searchText)
        searchController?.isActive = false
        presenter?.fetchRecipes(searchText: searchText)
    }
    
    
}

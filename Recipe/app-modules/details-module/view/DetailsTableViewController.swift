//
//  DetailsTableViewController.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import UIKit
import SafariServices

class DetailsTableViewController: UITableViewController {

    var viewModels = [Identity]()
    var presenter: DetailsViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    func fillDetailsRecipeViewModel(detailRecipe:RecipeModel?){
        if let unwrappedDetailsrecipe = detailRecipe{
            if let image = unwrappedDetailsrecipe.image {
                viewModels.append(DetailsImageViewModel(imageUri: image))
            }
            if let label = unwrappedDetailsrecipe.label {
                viewModels.append(DetailsTitleViewModel(title: label))
            }
            viewModels.append(DetailsIngredientsTitleViewModel())
            if let ingredients = unwrappedDetailsrecipe.ingredientLines {
                viewModels = viewModels + ingredients.map{return DetailsIngredientsViewModel(ingredient: $0)}
            }
            if let uri = unwrappedDetailsrecipe.uri {
                viewModels.append(DetailsLinkViewModel(link: uri))
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModels[indexPath.row].identifier, for: indexPath)
            (cell as? Refreshable)?.populate(viewModel: viewModels[indexPath.row])
            return cell
        }else if indexPath.row < viewModels.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModels[indexPath.row].identifier, for: indexPath)
            (cell as? Refreshable)?.populate(viewModel: viewModels[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModels[indexPath.row].identifier, for: indexPath)
            (cell as? Refreshable)?.populate(viewModel: viewModels[indexPath.row])
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLink)))
            return cell
        }
        
    }
    

    @objc func openLink(){
        if let uriViewModel = viewModels.last as? DetailsLinkViewModel {
            presenter?.openLink(navigationConroller: navigationController!, uri: uriViewModel.link)
        }
    }
}



extension DetailsTableViewController: DetailsPresenterToViewProtocol{
    
}

extension DetailsTableViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
}

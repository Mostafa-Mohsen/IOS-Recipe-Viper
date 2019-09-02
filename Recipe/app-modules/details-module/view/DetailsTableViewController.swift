//
//  DetailsTableViewController.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import UIKit
import SDWebImage
import SafariServices

class DetailsTableViewController: UITableViewController {

    var detailRecipe: RecipeModel?
    var presenter: DetailsViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let recipe = detailRecipe {
            return (4 + recipe.ingredientLines!.count);
        }else{
            return 0;
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! DetailsImageTableViewCell
            cell.detailsImage.sd_setImage(with: URL(string: detailRecipe!.image!), placeholderImage: UIImage(named: "placeHolder"))
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! DetailsTitleTableViewCell
            cell.detailsTitle.text = detailRecipe!.label
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
            
            return cell
        }else if indexPath.row < detailRecipe!.ingredientLines!.count + 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell4", for: indexPath) as! DetailsIngredientsTableViewCell
            cell.detailsIngredients.text = detailRecipe!.ingredientLines![indexPath.row - 3]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell5", for: indexPath) as! DetailsLinkTableViewCell
            cell.detailsLink.text = detailRecipe!.uri
            cell.detailsLink.isUserInteractionEnabled = true
            cell.detailsLink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLink)))
            return cell
        }

        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func openLink(){
        presenter?.openLink(navigationConroller: navigationController!, uri: detailRecipe!.uri!)
    }
}



extension DetailsTableViewController: DetailsPresenterToViewProtocol{
    
}

extension DetailsTableViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
}

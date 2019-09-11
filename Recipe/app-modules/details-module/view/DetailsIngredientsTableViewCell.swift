//
//  DetailsIngredientsTableViewCell.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import UIKit

class DetailsIngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsIngredients: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DetailsIngredientsTableViewCell: Refreshable {
    func populate(viewModel: Any) {
        guard let ingredientViewModel = viewModel as? DetailsIngredientsViewModel else {return}
        detailsIngredients.text = ingredientViewModel.ingredient
    }
}

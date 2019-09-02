//
//  RecipesTableViewCell.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var recipeHealthLabels: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

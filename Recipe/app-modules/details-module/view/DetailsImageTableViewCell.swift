//
//  DetailsImageTableViewCell.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsImageTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DetailsImageTableViewCell: Refreshable {
    func populate(viewModel: Any) {
        guard let imageViewModel = viewModel as? DetailsImageViewModel else {return}
        detailsImage.sd_setImage(with: URL(string: imageViewModel.imageUri), placeholderImage: UIImage(named: "placeHolder"))
    }
}

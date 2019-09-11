//
//  DetailsLinkTableViewCell.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import UIKit

class DetailsLinkTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsLink: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DetailsLinkTableViewCell: Refreshable {
    func populate(viewModel: Any) {
        guard let linkViewModel = viewModel as? DetailsLinkViewModel else {return}
        detailsLink.text = linkViewModel.link
    }
}

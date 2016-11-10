//
//  ServiceTableViewCell.swift
//  splittable
//
//  Created by Yan-Yi Li on 10/11/2016.
//  Copyright © 2016 Yan-Yi Li. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

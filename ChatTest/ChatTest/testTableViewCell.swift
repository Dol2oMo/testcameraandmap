//
//  testTableViewCell.swift
//  ChatTest
//
//  Created by MC-MG57035 on 5/9/2560 BE.
//  Copyright © 2560 Dol2oMo. All rights reserved.
//

import UIKit

class testTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ProfileImage:UIImageView!
    @IBOutlet var Profilelabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

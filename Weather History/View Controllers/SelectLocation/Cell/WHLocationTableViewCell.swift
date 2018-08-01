//
//  WHLocationTableViewCell.swift
//  Weather History
//
//  Created by Hanna Karnaukh on 8/1/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import UIKit

class WHLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
}

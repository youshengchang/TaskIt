//
//  TaskCell.swift
//  TaskIt
//
//  Created by yousheng chang on 10/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet var taskLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

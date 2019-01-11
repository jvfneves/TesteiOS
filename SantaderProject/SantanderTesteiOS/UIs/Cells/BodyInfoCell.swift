//
//  BodyInfoCell.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 12/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import UIKit

class BodyInfoCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var btDownload: UIButton!
    @IBOutlet weak var lbPercentage: UILabel!
    
    var actDownloadNew : (()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actDownload(_ sender: UIButton) {
        self.actDownloadNew?()
    }
}

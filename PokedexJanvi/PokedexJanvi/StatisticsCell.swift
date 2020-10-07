//
//  StatisticsCell.swift
//  PokedexJanvi
//
//  Created by Janvi Shah on 10/6/20.
//

import UIKit
class StatisticsCell: UITableViewCell {
    
    @IBOutlet weak var statisticsName: UILabel!
    
    @IBOutlet weak var statistic: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

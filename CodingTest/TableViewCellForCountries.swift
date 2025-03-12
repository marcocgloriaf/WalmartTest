//
//  TableViewCellForCountries.swift
//  CodingTest
//
//  Created by Marco Gloria on 04/03/25.
//

import UIKit

class TableViewCellForCountries: UITableViewCell {

    @IBOutlet weak var labelCountryName: UILabel!
    @IBOutlet weak var labelCountryCode: UILabel!
    @IBOutlet weak var labelCountryRegion: UILabel!
    @IBOutlet weak var labelCountryCapital: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

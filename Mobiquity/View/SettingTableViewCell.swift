//
//  SettingTableViewCell.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var hdrLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class var reuseIdentifier: String {
        return "settingCell"
    }
    class var nibName: String {
        return "SettingTableViewCell"
    }
}

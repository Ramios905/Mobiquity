//
//  ListTableCell.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import UIKit

class ListTableCell: UITableViewCell {

    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var windlbl: UILabel!
    @IBOutlet weak var cloudLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var locModel : LocationDetailViewModel? {
        didSet {
                        
            name.text = locModel?.locationName
            tempLbl.text = MUtility().converTemp(value: locModel?.temp ?? "0") 
            humidityLbl.text = "\(locModel?.humidity ?? "0")%"
            windlbl.text = "\(locModel?.wind ?? "0")m/sec"
            cloudLbl.text = "\(locModel?.cloud ?? "0")%"
            dateLbl.text = "\(MUtility().convertToDateWithMilliseconds(seconds: locModel?.date ?? 0))"
            desLbl.text = locModel?.des
            
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class var reuseIdentifier: String {
        return "listCell"
    }
    class var nibName: String {
        return "ListTableCell"
    }
}

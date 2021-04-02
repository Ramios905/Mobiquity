//
//  LocCollectionViewCell.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import UIKit

class LocCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var locName: UILabel!
    @IBOutlet weak var favSwt: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
    }
    
    class var reuseIdentifier: String {
        return "locCell"
    }
    class var nibName: String {
        return "LocCollectionViewCell"
    }
    
    var locModel : LocationAddViewModel? {
        didSet {

            locName.text = locModel?.locationName
            favSwt.setImage(UIImage(named: locModel?.fav == true ? "fav" : "unfav"), for: .normal)
        }
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
            
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
            
        layoutAttributes.frame = frame
            
        return layoutAttributes
    }
}

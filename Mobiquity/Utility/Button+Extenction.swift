//
//  Button+Extenction.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import Foundation
import UIKit

class RoundedButton: UIButton {

   @IBInspectable var titleText: String? {
       didSet {
           self.setTitle(titleText, for: .normal)
           self.setTitleColor(.systemGreen, for: .normal)
       }
   }

   override init(frame: CGRect){
       super.init(frame: frame)
   }
   
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }

   override func layoutSubviews() {
       super.layoutSubviews()
       setup()
   }

   func setup() {
       self.clipsToBounds = true
       self.layer.cornerRadius = self.bounds.size.height/2
   }
}

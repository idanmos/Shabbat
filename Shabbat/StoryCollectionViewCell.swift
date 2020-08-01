//
//  StoryCollectionViewCell.swift
//  Shabbat Pro
//
//  Created by Idan Moshe on 29/07/2020.
//  Copyright © 2020 Idan Moshe. All rights reserved.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "StoryCollectionViewCell"
    
    @IBOutlet weak var currentMonthView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        self.currentMonthView.isHidden = true
        
        self.currentMonthView.layer.cornerRadius = self.currentMonthView.frame.height/2
        self.currentMonthView.layer.borderWidth = 3
        self.currentMonthView.layer.borderColor = UIColor.green.cgColor
        self.currentMonthView.layer.masksToBounds = true
        self.currentMonthView.clipsToBounds = true
        
        self.imageView.layer.cornerRadius = self.imageView.frame.height/2
        self.imageView.layer.borderWidth = 1.5
        self.imageView.layer.borderColor = UIColor.random().cgColor
        self.imageView.layer.masksToBounds = true
        self.imageView.clipsToBounds = true
    }

}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

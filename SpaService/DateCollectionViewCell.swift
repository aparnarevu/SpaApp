//
//  DateCollectionViewCell.swift
//  SpaService
//
//  Created by Aparna Revu on 2/13/17.
//  Copyright © 2017 Aparna Revu. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel : UILabel?
    @IBOutlet weak var dayLabel : UILabel?
    var isCellSelected:Bool = true
    
    func updateCell()  {
        self.isCellSelected = !self.isCellSelected
        self.backgroundColor =  isCellSelected ? UIColor.white : UIColor.red
    }

}

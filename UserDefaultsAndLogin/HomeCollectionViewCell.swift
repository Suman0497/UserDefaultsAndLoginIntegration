//
//  HomeCollectionViewCell.swift
//  UserDefaultsAndLogin
//
//  Created by apple on 26/09/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var countLabel: UILabel!
    
    func counting(with counts: String){
        countLabel.text = counts
        
    }
}


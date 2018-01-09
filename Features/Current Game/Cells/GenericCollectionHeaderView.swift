//
//  GenericCollectionHeaderView.swift
//  Judgement
//
//  Created by Oliver Hauth on 31.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit

class GenericCollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setTitle(aTitle: String) {
        titleLabel.text = aTitle
    }
}


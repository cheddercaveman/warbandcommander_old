//
//  GenericCollectionHeaderView.swift
//  Judgement
//
//  Created by Oliver Hauth on 31.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import UIKit

class GenericCollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setTitle(aTitle: String) {
        titleLabel.text = aTitle
    }
}


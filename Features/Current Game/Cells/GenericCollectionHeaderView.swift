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
    @IBOutlet weak var addButton: UIButton!
    
    func setTitle(aTitle: String) {
        titleLabel.text = aTitle
    }
    
    func showAddButton() {
        self.addButton.alpha = 1.0
    }

    func hideAddButton() {
        self.addButton.alpha = 0.0
    }
}


//
//  ShrineCollectionViewCell.swift
//  Judgement
//
//  Created by Oliver Hauth on 27.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import UIKit

class ShrineCollectionViewCell: CardCollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var traitLabel: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    private var shrine: ShrineModel?
    
    override func setCard(aCard: CardBase, forindex anIndex: Int) {
        let aShrine: ShrineModel = aCard as! ShrineModel
        
        self.shrine = aShrine
        if (self.shrine == nil) {
            return
        }
        self.detailsButton!.tag = anIndex
        self.addButton!.tag = anIndex
        self.nameLabel!.text = self.shrine!.name
        self.traitLabel!.text = self.shrine!.trait
    }
    
}

//
//  ShrineCardCell.swift
//  Judgement
//
//  Created by Oliver Hauth on 27.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit

class ShrineCardCell: BaseCardCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var traitLabel: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    private var shrine: ShrineModel?
    
    override func setCard(aCard: CardBase, forindex anIndex: Int) {
        self.shrine = aCard as? ShrineModel
        
        if (self.shrine != nil) {
            self.detailsButton!.tag = anIndex
            self.addButton!.tag = anIndex
            self.nameLabel!.text = self.shrine!.name
            self.traitLabel!.text = self.shrine!.trait
        }
    }
    
}

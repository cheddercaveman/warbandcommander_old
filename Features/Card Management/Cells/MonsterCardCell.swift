//
//  MonsterCardCell.swift
//  Judgement
//
//  Created by Oliver Hauth on 27.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import UIKit

class MonsterCardCell: BaseCardCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var traitLabel: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    private var monster: MonsterModel?
    
    override func setCard(aCard: CardBase, forindex anIndex: Int) {
        self.monster = aCard as? MonsterModel
        
        if (self.monster != nil) {
            self.detailsButton!.tag = anIndex
            self.addButton!.tag = anIndex
            self.nameLabel!.text = self.monster!.name
            self.traitLabel!.text = self.monster!.trait
        }
    }

}

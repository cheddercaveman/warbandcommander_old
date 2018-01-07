//
//  MonsterCollectionViewCell.swift
//  Judgement
//
//  Created by Oliver Hauth on 27.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import UIKit

class MonsterCollectionViewCell: CardCollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var traitLabel: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    private var monster: MonsterModel?
    
    override func setCard(aCard: CardBase, forindex anIndex: Int) {
        let aMonster: MonsterModel = aCard as! MonsterModel
        
        self.monster = aMonster
        if (self.monster == nil) {
            return
        }
        self.detailsButton!.tag = anIndex
        self.addButton!.tag = anIndex
        self.nameLabel!.text = self.monster!.name
        self.traitLabel!.text = self.monster!.trait
    }

}

//
//  CCharacterCardCell.swift
//  Judgement
//
//  Created by Oliver Hauth on 25.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import UIKit

class CharacterCardCell: BaseCardCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var traitLabel: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    private var character: CharacterModel?
    
    override func setCard(aCard: CardBase, forindex anIndex: Int) {
        self.character = aCard as? CharacterModel

        if (self.character != nil) {
            self.detailsButton!.tag = anIndex
            self.addButton!.tag = anIndex
            self.nameLabel!.text = self.character!.name
            self.roleLabel!.text = self.character!.battlefieldRole.rawValue
            self.traitLabel!.text = String(format: "%@ %@", self.character!.race, self.character!.trait)
        }
    }
}

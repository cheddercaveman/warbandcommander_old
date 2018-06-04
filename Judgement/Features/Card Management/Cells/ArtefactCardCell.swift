//
//  ArtefactCardCell.swift
//  Judgement
//
//  Created by Oliver Hauth on 28.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit

class ArtefactCardCell: BaseCardCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var traitLabel: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    private var artefact: ArtefactModel?
    
    override func setCard(aCard: CardBase, forindex anIndex: Int) {
        self.artefact = aCard as? ArtefactModel
        if (self.artefact != nil) {
            self.detailsButton!.tag = anIndex
            self.addButton!.tag = anIndex
            self.nameLabel!.text = self.artefact!.name
            self.traitLabel!.text = self.artefact!.trait.rawValue
        }
    }
    
}


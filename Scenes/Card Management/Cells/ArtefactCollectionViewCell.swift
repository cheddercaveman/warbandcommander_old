//
//  ArtefactCollectionViewCell.swift
//  Judgement
//
//  Created by Oliver Hauth on 28.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import UIKit

class ArtefactCollectionViewCell: CardCollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var traitLabel: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    private var artefact: ArtefactModel?
    
    override func setCard(aCard: CardBase, forindex anIndex: Int) {
        let aArtefact: ArtefactModel = aCard as! ArtefactModel
        
        self.artefact = aArtefact
        if (self.artefact == nil) {
            return
        }
        self.detailsButton!.tag = anIndex
        self.addButton!.tag = anIndex
        self.nameLabel!.text = self.artefact!.name
        self.traitLabel!.text = self.artefact!.trait.rawValue
    }
    
}


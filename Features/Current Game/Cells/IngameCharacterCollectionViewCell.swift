//
//  IngameCharacterCollectionViewCell.swift
//  Judgement
//
//  Created by Oliver Hauth on 29.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import UIKit

protocol IngameCharacterCollectionViewCellDelegate {
    func deleteButtonTouched(sender aSender: IngameCharacterCollectionViewCell )
    func damageIncreased(sender aSender: IngameCharacterCollectionViewCell )
    func damageDecreased(sender aSender: IngameCharacterCollectionViewCell )
    func levelIncreased(sender aSender: IngameCharacterCollectionViewCell )
    func levelDecreased(sender aSender: IngameCharacterCollectionViewCell )
}

class IngameCharacterCollectionViewCell: UICollectionViewCell {
    var _state: CharacterState?
    var state: CharacterState? {
        get { return self._state }
        set {
            self._state = newValue
            updateCell()
        }
    }
    
    var _indexPath: Int = 0
    var indexPath: Int {
        get { return self._indexPath }
        set {
            self._indexPath = newValue
            
            self.tag = Int(self._indexPath)
            self.detailsButton.tag = Int(self._indexPath)
            self.removeButton.tag = Int(self._indexPath)
            self.offensiveArtefactButton.tag = Int(self._indexPath)
            self.defensiveArtefactButton.tag = Int(self._indexPath)
        }
    }


    var delegate: IngameCharacterCollectionViewCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var traitLabel: UILabel!
    
    @IBOutlet weak var statMovLabel: UILabel!
    @IBOutlet weak var statAgiLabel: UILabel!
    @IBOutlet weak var statResLabel: UILabel!
    @IBOutlet weak var statMelLabel: UILabel!
    @IBOutlet weak var statMagLabel: UILabel!
    @IBOutlet weak var statRngLabel: UILabel!
    @IBOutlet weak var statSoulHarvestLabel: UILabel!
    @IBOutlet weak var statLifeLeftLabel: UILabel!
    
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var damageTakenLabel: UILabel!
    
    @IBOutlet weak var offensiveArtefactButton: UIButton!
    @IBOutlet weak var defensiveArtefactButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    func updateCell() {
        self.nameLabel!.text = self.state!.character!.name
        self.roleLabel!.text = self.state!.character!.battlefieldRole.rawValue
        self.traitLabel!.text = self.state!.character!.trait
        
        self.statMovLabel!.text = self.state!.character!.statMOV
        self.statAgiLabel!.text = self.state!.character!.statAGI
        self.statResLabel!.text = self.state!.character!.statRES
        self.statMelLabel!.text = self.state!.character!.statMEL
        self.statMagLabel!.text = self.state!.character!.statMAG
        self.statRngLabel!.text = self.state!.character!.statRNG
        self.statSoulHarvestLabel!.text = self.state!.character!.soulHarvest ?? ""
        self.statLifeLeftLabel!.text = String(self.currentLifeLeft())
        
        self.damageTakenLabel!.text = String(self.state!.damageTaken)
        switch (self.currentLifeLeft()) {
        case 0:
            self.statLifeLeftLabel!.textColor = .red
        default:
            self.statLifeLeftLabel!.textColor = .darkGray
        }
        self.statLifeLeftLabel!.text = String(self.currentLifeLeft())
        
        self.currentLevelLabel!.text = String(self.state!.currentLevel)
        
        if let artefact = self.state?.offensiveArtefact {
            self.offensiveArtefactButton.titleLabel!.text = "Offensive Artefact: \(artefact.name) / \(artefact.summary)"
        } else {
            self.offensiveArtefactButton.titleLabel!.text = "Offensive Artefact"
        }
        
        if let artefact = self.state?.defensiveArtefact {
            self.defensiveArtefactButton.titleLabel!.text = "Defensive Artefact: \(artefact.name) / \(artefact.summary)"
        } else {
            self.defensiveArtefactButton.titleLabel!.text = "Defensive Artefact"
        }
        
        self.setNeedsDisplay()
    }
    
    func initializeCell(withCharacter aCharacter: CharacterState) {
        self.state = aCharacter
    }
    
    func currentLifeLeft() -> Int {
        var baseLife = 0
        
        switch (self.state!.currentLevel) {
        case 1:
            baseLife = Int(self.state!.character!.lifeLevel1)
        case 2:
            baseLife = Int(self.state!.character!.lifeLevel2)
        default:
            baseLife = Int(self.state!.character!.lifeLevel3)
        }
        
        return baseLife - self.state!.damageTaken
    }
    
    @IBAction func removeButtonTouched(_ sender: UIButton) {
        self.delegate?.deleteButtonTouched(sender: self)
    }
    
    @IBAction func damageDecrease(_ sender: UIButton) {
        self.delegate?.damageDecreased(sender: self)
    }
    
    @IBAction func damageIncrease(_ sender: UIButton) {
        self.delegate?.damageIncreased(sender: self)
    }
    
    @IBAction func levelDecrease(_ sender: UIButton) {
        self.delegate?.levelDecreased(sender: self)
    }
    
    @IBAction func levelIncrease(_ sender: UIButton) {
        self.delegate?.levelIncreased(sender: self)
    }
}

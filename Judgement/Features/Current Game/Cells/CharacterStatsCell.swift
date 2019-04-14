//
//  CharacterStatsCell.swift
//  Judgement
//
//  Created by Oliver Hauth on 29.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit

protocol CharacterStatsCellDelegate {
    func deleteButtonTouched(sender aSender: CharacterStatsCell)
    func damageIncreased(sender aSender: CharacterStatsCell)
    func damageDecreased(sender aSender: CharacterStatsCell)
    func levelIncreased(sender aSender: CharacterStatsCell)
    func levelDecreased(sender aSender: CharacterStatsCell)
    func revive(sender aSender: CharacterStatsCell)
    func soulsIncreased(sender aSender: CharacterStatsCell)
    func soulsDecreased(sender aSender: CharacterStatsCell)
    func bankSouls(sender aSender: CharacterStatsCell)
}

class CharacterStatsCell: UICollectionViewCell {
    var state: CharacterState? = nil {
        didSet {
            if self.state != nil {
                updateCell()
            }
        }
    }
    
    var indexPath: Int? = nil {
        didSet {
            if let indexPath = self.indexPath {
                self.tag = indexPath
                self.detailsButton.tag = indexPath
                self.removeButton.tag = indexPath
                self.offensiveArtefactButton.tag = indexPath
                self.defensiveArtefactButton.tag = indexPath
                self.offensiveArtefactDetailButton.tag = indexPath
                self.defensiveArtefactDetailButton.tag = indexPath
            }
        }
    }

    @IBOutlet weak var withSoulsConstraint: NSLayoutConstraint!    
    @IBOutlet weak var withoutSoulsConstraint: NSLayoutConstraint!

    var delegate: CharacterStatsCellDelegate?
    
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
    
    @IBOutlet weak var weapon1Name: UILabel!
    @IBOutlet weak var weapon1Type: UILabel!
    @IBOutlet weak var weapon1Cost: UILabel!
    @IBOutlet weak var weapon1Range: UILabel!
    @IBOutlet weak var weapon1Glance: UILabel!
    @IBOutlet weak var weapon1Solid: UILabel!
    @IBOutlet weak var weapon1Crit: UILabel!
    
    @IBOutlet weak var weapon2Name: UILabel!
    @IBOutlet weak var weapon2Type: UILabel!
    @IBOutlet weak var weapon2Cost: UILabel!
    @IBOutlet weak var weapon2Range: UILabel!
    @IBOutlet weak var weapon2Glance: UILabel!
    @IBOutlet weak var weapon2Solid: UILabel!
    @IBOutlet weak var weapon2Crit: UILabel!
    
    @IBOutlet weak var weapon3Name: UILabel!
    @IBOutlet weak var weapon3Type: UILabel!
    @IBOutlet weak var weapon3Cost: UILabel!
    @IBOutlet weak var weapon3Range: UILabel!
    @IBOutlet weak var weapon3Glance: UILabel!
    @IBOutlet weak var weapon3Solid: UILabel!
    @IBOutlet weak var weapon3Crit: UILabel!
    
    
    var weaponRows: [WeaponRow] = []
    
    @IBOutlet weak var decreaseLevelButton: UIButton!
    @IBOutlet weak var increaseLevelButton: UIButton!
    @IBOutlet weak var reviveButton: UIButton!
    
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var damageTakenLabel: UILabel!
    @IBOutlet weak var currentSoulsLabel: UILabel!
    
    @IBOutlet weak var offensiveArtefactButton: UIButton!
    @IBOutlet weak var defensiveArtefactButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    @IBOutlet weak var offensiveArtefactDetailButton: UIButton!
    @IBOutlet weak var defensiveArtefactDetailButton: UIButton!
    @IBOutlet weak var blurView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var statsView: UIView!
    
    @IBOutlet weak var soulsView: UIView!
    
    func updateCell() {
        self.nameLabel!.text = self.state!.character!.name
        self.roleLabel!.text = self.state!.character!.battlefieldRole.rawValue
        self.traitLabel!.text = String(format: "%@ %@", self.state!.character!.race, self.state!.character!.trait)

        let movStat = self.state!.get(stat: .mov)
        self.statMovLabel!.text = movStat.value
        self.statMovLabel!.textColor = movStat.color
        
        let agiStat = self.state!.get(stat: .agi)
        self.statAgiLabel!.text = agiStat.value
        self.statAgiLabel!.textColor = agiStat.color
        
        let resStat = self.state!.get(stat: .res)
        self.statResLabel!.text = resStat.value
        self.statResLabel!.textColor = resStat.color
        
        let melStat = self.state!.get(stat: .mel)
        self.statMelLabel!.text = melStat.value
        self.statMelLabel!.textColor = melStat.color
        
        let magStat = self.state!.get(stat: .mag)
        self.statMagLabel!.text = magStat.value
        self.statMagLabel!.textColor = magStat.color
        
        let rngStat = self.state!.get(stat: .rng)
        self.statRngLabel!.text = rngStat.value
        self.statRngLabel!.textColor = rngStat.color
        
        self.currentSoulsLabel!.text = String(self.state!.souls)
        
        self.reviveButton.setTitle(self.state!.defensiveArtefact?.id == Artefact.elixirOfLife.rawValue ? "Use Elixir of Life" : "Revive", for: .normal)
        
        self.statSoulHarvestLabel!.text = self.state!.character!.soulHarvest ?? "-"
        self.statLifeLeftLabel!.text = String(self.currentLifeLeft())
        
        self.damageTakenLabel!.text = String(self.state!.damageTaken)
        self.statLifeLeftLabel!.textColor = (self.currentLifeLeft() == 0) ? UIColor.red : UIColor.lightGray
        self.statLifeLeftLabel!.text = String(self.currentLifeLeft())
        
        self.increaseLevelButton.alpha = self.state!.character!.canLevel ? 1.0 : 0.0
        self.decreaseLevelButton.alpha = self.state!.character!.canLevel ? 1.0 : 0.0
        
        self.currentLevelLabel!.text = self.state!.character!.canLevel ? String(self.state!.currentLevel) : "N/A"
        
        self.offensiveArtefactDetailButton.isEnabled = self.state?.offensiveArtefact != nil
        self.offensiveArtefactButton.setTitle(self.state?.offensiveArtefact?.name ?? "Offensive Artefact", for: .normal)
        
        self.defensiveArtefactDetailButton.isEnabled = self.state?.defensiveArtefact != nil
        self.defensiveArtefactButton.setTitle(self.state?.defensiveArtefact?.name ?? "Defensive Artefact", for: .normal)
        
        self.blurView.alpha = (self.currentLifeLeft() == 0) ? 1.0 : 0.0
        
        for i in 0 ..< weaponRows.count {
            self.weaponRows[i].nameLabel.text = (self.state!.character!.attacks.count > i) ? self.state!.character!.attacks[i].name : ""
            self.weaponRows[i].typeLabel.text = (self.state!.character!.attacks.count > i) ? AttackTypeNames[self.state!.character!.attacks[i].type.rawValue] : ""
            self.weaponRows[i].costLabel.text = (self.state!.character!.attacks.count > i) ? self.state!.character!.attacks[i].cost : ""
            self.weaponRows[i].rangeLabel.text = (self.state!.character!.attacks.count > i) ? self.state!.character!.attacks[i].range : ""
            self.weaponRows[i].glanceLabel.text = (self.state!.character!.attacks.count > i) ? self.state!.character!.attacks[i].glanceDamage : ""
            self.weaponRows[i].solidLabel.text = (self.state!.character!.attacks.count > i) ? self.state!.character!.attacks[i].solidDamage : ""
            self.weaponRows[i].critLabel.text = (self.state!.character!.attacks.count > i) ? self.state!.character!.attacks[i].critDamage : ""
        }

        self.setNeedsDisplay()
    }
    
    func initializeCell(withCharacter aCharacter: CharacterState) {
        self.weaponRows = [
            WeaponRow(nameLabel: self.weapon1Name, typeLabel: self.weapon1Type, costLabel: self.weapon1Cost, rangeLabel: self.weapon1Range, glanceLabel: self.weapon1Glance, solidLabel: self.weapon1Solid, critLabel: self.weapon1Crit),
            WeaponRow(nameLabel: self.weapon2Name, typeLabel: self.weapon2Type, costLabel: self.weapon2Cost, rangeLabel: self.weapon2Range, glanceLabel: self.weapon2Glance, solidLabel: self.weapon2Solid, critLabel: self.weapon2Crit),
            WeaponRow(nameLabel: self.weapon3Name, typeLabel: self.weapon3Type, costLabel: self.weapon3Cost, rangeLabel: self.weapon3Range, glanceLabel: self.weapon3Glance, solidLabel: self.weapon3Solid, critLabel: self.weapon3Crit)
        ]

        self.state = aCharacter
        
        if self.state!.character?.soulHarvest == nil {
            self.soulsView.removeFromSuperview()
            self.withoutSoulsConstraint.isActive = true
            self.withSoulsConstraint.isActive = false
        }
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
    
    @IBAction func reviveButtonTouched(_ sender: UIButton) {
        self.delegate?.revive(sender: self)
    }
    
    @IBAction func decreaseSoulsButtonTouched(_ sender: UIButton) {
        self.delegate?.soulsDecreased(sender: self)
    }
    
    @IBAction func increaseSoulsButtonTouched(_ sender: UIButton) {
        self.delegate?.soulsIncreased(sender: self)
    }
    
    @IBAction func bankSoulsButtonTouched(_ sender: UIButton) {
        self.delegate?.bankSouls(sender: self)
    }
}

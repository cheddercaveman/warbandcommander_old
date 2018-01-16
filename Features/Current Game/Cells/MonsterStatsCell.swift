
//
//  MonsterStatsCell.swift
//  Judgement
//
//  Created by Oliver Hauth on 29.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit

protocol MonsterStatsCellDelegate {
    func deleteButtonTouched(sender aSender: MonsterStatsCell)
    func damageIncreased(sender aSender: MonsterStatsCell)
    func damageDecreased(sender aSender: MonsterStatsCell)
    func revive(sender aSender: MonsterStatsCell)
}

class MonsterStatsCell: UICollectionViewCell {
    var state: MonsterState? = nil {
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
            }
        }
    }
    
    var delegate: MonsterStatsCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var traitLabel: UILabel!
    
    @IBOutlet weak var statMovLabel: UILabel!
    @IBOutlet weak var statAgiLabel: UILabel!
    @IBOutlet weak var statResLabel: UILabel!
    @IBOutlet weak var statMelLabel: UILabel!
    @IBOutlet weak var statMagLabel: UILabel!
    @IBOutlet weak var statRngLabel: UILabel!
    @IBOutlet weak var fateBountyLabel: UILabel!
    @IBOutlet weak var statLifeLeftLabel: UILabel!
    
    @IBOutlet weak var damageTakenLabel: UILabel!
    
    
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
    
    
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var blurView: UIView!
    
    
    func updateCell() {
        self.nameLabel!.text = self.state!.monster!.name
        self.traitLabel!.text = self.state!.monster!.trait
        
        self.statMovLabel!.text = self.state!.monster!.statMOV ?? "-"
        self.statAgiLabel!.text = self.state!.monster!.statAGI ?? "-"
        self.statResLabel!.text = self.state!.monster!.statRES ?? "-"
        self.statMelLabel!.text = self.state!.monster!.statMEL ?? "-"
        self.statMagLabel!.text = self.state!.monster!.statMAG ?? "-"
        self.statRngLabel!.text = self.state!.monster!.statRNG ?? "-"
        self.fateBountyLabel!.text = self.state!.monster!.fateBounty ?? ""
        self.statLifeLeftLabel!.text = String(self.currentLifeLeft())
        
        self.damageTakenLabel!.text = String(self.state!.damageTaken)
        self.statLifeLeftLabel!.textColor = (self.currentLifeLeft() == 0) ? UIColor.red : UIColor.lightGray
        self.statLifeLeftLabel!.text = String(self.currentLifeLeft())
        
        self.blurView.alpha = (self.currentLifeLeft() == 0) ? 1.0 : 0.0
        
        for i in 0 ..< weaponRows.count {
            self.weaponRows[i].nameLabel.text = (self.state!.monster!.attacks.count > i) ? self.state!.monster!.attacks[i].name : ""
            self.weaponRows[i].typeLabel.text = (self.state!.monster!.attacks.count > i) ? AttackTypeNames[self.state!.monster!.attacks[i].type.rawValue] : ""
            self.weaponRows[i].costLabel.text = (self.state!.monster!.attacks.count > i) ? self.state!.monster!.attacks[i].cost : ""
            self.weaponRows[i].rangeLabel.text = (self.state!.monster!.attacks.count > i) ? self.state!.monster!.attacks[i].range : ""
            self.weaponRows[i].glanceLabel.text = (self.state!.monster!.attacks.count > i) ? self.state!.monster!.attacks[i].glanceDamage : ""
            self.weaponRows[i].solidLabel.text = (self.state!.monster!.attacks.count > i) ? self.state!.monster!.attacks[i].solidDamage : ""
            self.weaponRows[i].critLabel.text = (self.state!.monster!.attacks.count > i) ? self.state!.monster!.attacks[i].critDamage : ""
        }
        
        self.setNeedsDisplay()
    }
    
    func initializeCell(withMonster aMonster: MonsterState) {
        self.weaponRows = [
            WeaponRow(nameLabel: self.weapon1Name, typeLabel: self.weapon1Type, costLabel: self.weapon1Cost, rangeLabel: self.weapon1Range, glanceLabel: self.weapon1Glance, solidLabel: self.weapon1Solid, critLabel: self.weapon1Crit),
            WeaponRow(nameLabel: self.weapon2Name, typeLabel: self.weapon2Type, costLabel: self.weapon2Cost, rangeLabel: self.weapon2Range, glanceLabel: self.weapon2Glance, solidLabel: self.weapon2Solid, critLabel: self.weapon2Crit),
            WeaponRow(nameLabel: self.weapon3Name, typeLabel: self.weapon3Type, costLabel: self.weapon3Cost, rangeLabel: self.weapon3Range, glanceLabel: self.weapon3Glance, solidLabel: self.weapon3Solid, critLabel: self.weapon3Crit)
        ]
        
        self.state = aMonster
    }
    
    func currentLifeLeft() -> Int {
        return self.state!.monster!.life - self.state!.damageTaken
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
    
    @IBAction func reviveButtonTouched(_ sender: UIButton) {
        self.delegate?.revive(sender: self)
    }
}


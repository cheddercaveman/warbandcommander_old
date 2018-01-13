
//
//  MonsterStatsCell.swift
//  Judgement
//
//  Created by Oliver Hauth on 29.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit

protocol MonsterStatsCellDelegate {
    func deleteButtonTouched(sender aSender: MonsterStatsCell )
    func damageIncreased(sender aSender: MonsterStatsCell )
    func damageDecreased(sender aSender: MonsterStatsCell )
}

class MonsterStatsCell: UICollectionViewCell {
    var _state: MonsterState?
    var state: MonsterState? {
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
    
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    
    func updateCell() {
        self.nameLabel!.text = self.state!.monster!.name
        self.traitLabel!.text = self.state!.monster!.trait
        
        self.statMovLabel!.text = self.state!.monster!.statMOV
        self.statAgiLabel!.text = self.state!.monster!.statAGI
        self.statResLabel!.text = self.state!.monster!.statRES
        self.statMelLabel!.text = self.state!.monster!.statMEL
        self.statMagLabel!.text = self.state!.monster!.statMAG
        self.statRngLabel!.text = self.state!.monster!.statRNG
        self.fateBountyLabel!.text = self.state!.monster!.fateBounty ?? ""
        self.statLifeLeftLabel!.text = String(self.currentLifeLeft())
        
        self.damageTakenLabel!.text = String(self.state!.damageTaken)
        self.statLifeLeftLabel!.textColor = (self.currentLifeLeft() == 0) ? UIColor.red : UIColor.lightGray
        self.statLifeLeftLabel!.text = String(self.currentLifeLeft())
        
        self.setNeedsDisplay()
    }
    
    func initializeCell(withMonster aMonster: MonsterState) {
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
}


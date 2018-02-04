//
//  CharacterStatsCell.swift
//  Judgement
//
//  Created by Oliver Hauth on 04.02.18.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit

protocol WarbandStatsCellDelegate {
    func increaseBankedSouls(sender aSender: WarbandStatsCell)
    func decreaseBankedSouls(sender aSender: WarbandStatsCell)
}

class WarbandStatsCell: UICollectionViewCell {
    var state: WarbandState? = nil {
        didSet {
            if self.state != nil {
                updateCell()
            }
        }
    }
    
    var delegate: WarbandStatsCellDelegate?
    
    @IBOutlet weak var bankedSoulsLabel: UILabel!
    @IBOutlet weak var overallSoulsLabel: UILabel!
    
    
    func updateCell() {
        self.bankedSoulsLabel!.text = String(self.state!.bankedSouls)
        self.overallSoulsLabel!.text = String(self.state!.overallSouls())
        
        self.setNeedsDisplay()
    }
    
    func initializeCell(withWarband aWarband: WarbandState) {
        self.state = aWarband
    }
    

    @IBAction func decreaseSoulsButtonTouched(_ sender: UIButton) {
        self.delegate?.decreaseBankedSouls(sender: self)
    }
    
    @IBAction func increaseSoulsButtonTouched(_ sender: UIButton) {
        self.delegate?.increaseBankedSouls(sender: self)
    }
    
}


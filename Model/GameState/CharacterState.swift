//
//  WarbandCharacterState.swift
//  Judgement
//
//  Created by Oliver Hauth on 30.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation
import UIKit
import GRDB

class CharacterState : Encodable, Decodable {
    var character: CharacterModel?
    var damageTaken: Int = 0
    var currentLevel: Int = 1
    var souls: Int = 0
    var offensiveArtefact: ArtefactModel?
    var defensiveArtefact: ArtefactModel?
    
    init(fromId: Int) {
        self.character = DatabaseService.sharedInstance.Characters?.first(where: { (c) -> Bool in
            c.id == fromId
        })
    }
    
    init(fromCharacter: CharacterModel) {
        self.character = fromCharacter
    }
    
    func currentMaxDamage() -> Int {
        switch self.currentLevel {
        case 1:
            return Int(self.character!.lifeLevel1)
        case 2:
            return Int(self.character!.lifeLevel2)
        default:
            return Int(self.character!.lifeLevel3)
        }
    }
    
    func currentLifeLeft() -> Int {
        return self.currentMaxDamage() - self.damageTaken
    }
    
    func increaseDamage() {
        if self.currentLifeLeft() > 0 {
            self.damageTaken += 1
        }
    }
    
    func decreaseDamage() {
        if self.damageTaken > 0 {
            self.damageTaken -= 1
        }
    }
    
    func increaseLevel() {
        if (self.currentLevel < 3) {
            self.currentLevel += 1
        }
    }
    
    func decreaseLevel() {
        if (self.currentLevel > 1) {
            self.currentLevel -= 1
        }
    }
    
    func addSoul() {
        self.souls += 1
    }
    
    func removeSoul() {
        if (self.souls > 0) {
            self.souls -= 1
        }
    }
    
    func assignOffensiveArtefact(anArtefact: ArtefactModel) {
        self.offensiveArtefact = anArtefact
    }
    
    func removeOffensiveArtefact() {
        self.offensiveArtefact = nil
    }
    
    func assignDefensiveArtefact(anArtefact: ArtefactModel) {
        self.defensiveArtefact = anArtefact
    }
    
    func removeDefensiveArtefact() {
        self.defensiveArtefact = nil
    }
    
    func revive() {
        self.damageTaken = self.character!.reviveDamage
    }
    
    func useElixirOfLife() {
        self.defensiveArtefact = nil
        self.damageTaken = self.currentMaxDamage() - 1
    }
    
    func get(stat: StatValue) -> (value: String, color: UIColor) {
        let unmodifiedColor: UIColor = .lightGray
        let modifiedColor: UIColor = UIColor(red:0.43, green:0.63, blue:0.76, alpha:1.0)
        
        var currentStat = "0"
        switch stat {
        case .mov:
            currentStat = self.character?.statMOV ?? "0"
            break
        case .agi:
            currentStat = self.character?.statAGI ?? "0"
            break
        case .res:
            currentStat = self.character?.statRES ?? "0"
            break
        case .mel:
            currentStat = self.character?.statMEL ?? "0"
            break
        case .mag:
            currentStat = self.character?.statMAG ?? "0"
            break
        case .rng:
            currentStat = self.character?.statRNG ?? "0"
            break
        case .soulharvest:
            currentStat = self.character?.soulHarvest ?? "0"
            break
        }
        
        if (stat.rawValue == self.offensiveArtefact?.statModified)
            || (stat.rawValue == self.defensiveArtefact?.statModified) {
            var currentStatInt = Int(currentStat)
            if currentStatInt == nil {
                return (value: currentStat, color: unmodifiedColor)
            }

            if (stat.rawValue == self.offensiveArtefact?.statModified) {
                currentStatInt! += (offensiveArtefact?.statModifiedAmount ?? 0)
            } else {
                currentStatInt! += (defensiveArtefact?.statModifiedAmount ?? 0)
            }
            
            return (value: "\(currentStatInt!)", color: modifiedColor)
        }
    
        if currentStat == "0" {
            currentStat = "-"
        }

        return (value: "\(currentStat)", color: unmodifiedColor)
    }
    
    private enum CodingKeys: String, CodingKey {
        case characterReferenceId
        case damageTaken
        case currentLevel
        case souls
        case offensiveArtefactReferenceId
        case defensiveArtefactReferenceId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let characterId = try container.decode(Int.self, forKey: .characterReferenceId)
        self.character = DatabaseService.sharedInstance.Characters?.first(where: { (c) -> Bool in
            return c.id == characterId
        })
        
        self.damageTaken = try container.decode(Int.self, forKey: .damageTaken)
        self.currentLevel = try container.decode(Int.self, forKey: .currentLevel)
        self.souls = try container.decode(Int?.self, forKey: .souls) ?? 0
        
        if let offensiveArtefactId = try container.decodeIfPresent(Int.self, forKey: .offensiveArtefactReferenceId) {
            self.offensiveArtefact = DatabaseService.sharedInstance.Artefacts?.first(where: { (a) -> Bool in
                return a.id == offensiveArtefactId
            })
        }
        
        if let defensiveArtefactId = try container.decodeIfPresent(Int.self, forKey: .defensiveArtefactReferenceId) {
            self.defensiveArtefact = DatabaseService.sharedInstance.Artefacts?.first(where: { (a) -> Bool in
                return a.id == defensiveArtefactId
            })
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.character?.id, forKey: .characterReferenceId)
        try container.encode(self.damageTaken, forKey: .damageTaken)
        try container.encode(self.currentLevel, forKey: .currentLevel)
        try container.encode(self.souls, forKey: .souls)
        try container.encodeIfPresent(self.offensiveArtefact?.id, forKey: .offensiveArtefactReferenceId)
        try container.encodeIfPresent(self.defensiveArtefact?.id, forKey: .defensiveArtefactReferenceId)
    }

}

//
//  WarbandCharacterState.swift
//  Judgement
//
//  Created by Oliver Hauth on 30.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation
import GRDB

class CharacterState : Encodable, Decodable {
    var character: CharacterModel?
    var damageTaken: Int = 0
    var currentLevel: Int = 1
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
    
    private enum CodingKeys: String, CodingKey {
        case characterReferenceId
        case damageTaken
        case currentLevel
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
        try container.encodeIfPresent(self.offensiveArtefact?.id, forKey: .offensiveArtefactReferenceId)
        try container.encodeIfPresent(self.defensiveArtefact?.id, forKey: .defensiveArtefactReferenceId)
    }

}

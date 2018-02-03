//
//  WarbandState.swift
//  Judgement
//
//  Created by Oliver Hauth on 30.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation
import GRDB

class WarbandState : Encodable, Decodable {
    var fate: Int = 1
    var bankedSouls = 0
    var effigyMaxLife: Int = 20
    var effigyDamageTaken: Int = 0
    var characters: [CharacterState] = []
    
    private enum CodingKeys: String, CodingKey {
        case fate
        case bankedSouls
        case effigyMaxLife
        case effigyDamageTaken
        case characters
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fate = try container.decode(Int.self, forKey: .fate)
        self.bankedSouls = try container.decode(Int.self, forKey: .bankedSouls)
        self.effigyMaxLife = try container.decode(Int.self, forKey: .effigyMaxLife)
        self.effigyDamageTaken = try container.decode(Int.self, forKey: .effigyDamageTaken)
        self.characters = try container.decode([CharacterState].self, forKey: .characters)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.fate, forKey: .fate)
        try container.encode(self.bankedSouls, forKey: .bankedSouls)
        try container.encode(self.effigyMaxLife, forKey: .effigyMaxLife)
        try container.encode(self.effigyDamageTaken, forKey: .effigyDamageTaken)
        try container.encode(self.characters, forKey: .characters)
    }
    
    func addCharacter(aCharacter: CharacterModel) {
        self.characters.append(CharacterState(fromCharacter: aCharacter))
    }
    
    func containsCharacter(aCharacter: CharacterModel) -> Bool {
        for c in self.characters {
            if c.character == aCharacter {
                return true
            }
        }
        
        return false
    }
    
    func artefactInUse(anArtefact: ArtefactModel) -> Bool {
        for c in self.characters {
            if c.offensiveArtefact == anArtefact ||
                c.defensiveArtefact == anArtefact {
                return true
            }
        }
        return false
    }
    
    func dismissArtefact(anArtefact: ArtefactModel) {
        for c in self.characters {
            if c.offensiveArtefact == anArtefact {
                c.offensiveArtefact = nil
            }
            if c.defensiveArtefact == anArtefact {
                c.defensiveArtefact = nil
            }
        }
    }
    
    func overallSouls() -> Int {
        var overallSouls: Int = self.bankedSouls
        for c in self.characters {
            overallSouls += c.souls
        }
        
        return overallSouls
    }
    
    func bankSouls(amount: Int) {
        self.bankedSouls += amount
    }
}

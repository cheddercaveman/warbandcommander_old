//
//  MonsterState.swift
//  Judgement
//
//  Created by Oliver Hauth on 04.01.18.
//  Copyright © 2018 Headblast Oberhausen e.V. All rights reserved.
//

import Foundation

class MonsterState : Encodable, Decodable {
    var monster: MonsterModel!
    var damageTaken: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case monsterReferenceId
        case damageTaken
    }
    
    init(aMonster: MonsterModel) {
        self.monster = aMonster
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let monsterId = try container.decode(Int.self, forKey: .monsterReferenceId)
        self.monster = DatabaseService.sharedInstance.Monsters?.first(where: { (m) -> Bool in
            return m.id == monsterId
        })
        self.damageTaken = try container.decode(Int.self, forKey: .damageTaken)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.monster.id, forKey: .monsterReferenceId)
        try container.encode(self.damageTaken, forKey: .damageTaken)
    }
    
    func currentLifeLeft() -> Int {
        return self.monster.life - self.damageTaken
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
}


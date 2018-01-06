//
//  GameState.swift
//  Judgement
//
//  Created by Oliver Hauth on 30.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import Foundation
import GRDB

class GameState : Encodable, Decodable{
    static let sharedInstance: GameState = GameState()
    
    var ownWarband: WarbandState
    var enemyWarband: WarbandState
    var monster: [MonsterState]
    
    private enum CodingKeys: String, CodingKey {
        case ownWarband
        case enemyWarband
        case monster
    }
    
    init() {
        self.ownWarband = WarbandState()
        self.enemyWarband = WarbandState()
        self.monster = []
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ownWarband = try container.decode(WarbandState.self, forKey: .ownWarband)
        self.enemyWarband = try container.decode(WarbandState.self, forKey: .enemyWarband)
        self.monster = try container.decode([MonsterState].self, forKey: .monster)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.ownWarband, forKey: .ownWarband)
        try container.encode(self.enemyWarband, forKey: .enemyWarband)
        try container.encode(self.monster, forKey: .monster)
    }

    func addMonster(monster: MonsterModel) {
        self.monster.append(MonsterState(aMonster: monster))
    }
    
    
}

//
//  CharacterModel.swift
//  Judgement
//
//  Created by Oliver Hauth on 22.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation
import GRDB

struct CharacterModel : CardBase, RowConvertible, TableMapping, Hashable, Equatable {
    static var databaseTableName: String { return "Characters" }
    static let databaseSelection: [SQLSelectable] = [AllColumns(), Column.rowID]
    
    enum Columns {
        static let id = Column("rowid")
        static let name = Column("name")
        static let race = Column("race")
        static let trait = Column("traits")
        static let battlefieldRole = Column("role")
        static let statMOV = Column("stat_MOV")
        static let statAGI = Column("stat_AGI")
        static let statRES = Column("stat_RES")
        static let statMEL = Column("stat_MEL")
        static let statMAG = Column("stat_MAG")
        static let statRNG = Column("stat_RNG")
        static let soulHarvest = Column("stat_SoulHarvest")
        static let lifeLevel1 = Column("life_Level1")
        static let lifeLevel2 = Column("life_Level2")
        static let lifeLevel3 = Column("life_Level3")
        static let reviveDamage = Column("reviveDamage")
        static let canLevel = Column("canlevel")
        static let multipleAllowed = Column("multipleAllowed")
        static let cardBasename = Column("cardbasename")
        static let cardAmount = Column("cardamount")
    }


    var id: Int = 0
    var name: String = ""
    var race: String = ""
    var trait: String = ""
    var battlefieldRole: BattlefieldRole = .hybrid
    var statMOV: String?
    var statAGI: String?
    var statRES: String?
    var statMEL: String?
    var statRNG: String?
    var statMAG: String?
    var soulHarvest: String?
    
    var lifeLevel1: Int = 0
    var lifeLevel2: Int = 0
    var lifeLevel3: Int = 0
    var reviveDamage: Int = 5
    
    var canLevel: Bool = true
    
    var cardBasename: String = ""
    var cardAmount: Int = 0
    
    var dependsOn: Int32?
    var multipleAllowed: Bool = false

    var attacks: [AttackModel] = []
    
    init(row: Row) {
        self.id = row[Columns.id]
        
        self.name = row[Columns.name]
        self.race = row[Columns.race]
        self.trait = row[Columns.trait]
        self.battlefieldRole = BattlefieldRole(rawValue: row[Columns.battlefieldRole])!
        
        self.statMOV = row[Columns.statMOV]
        self.statAGI = row[Columns.statAGI]
        self.statRES = row[Columns.statRES]
        self.statMEL = row[Columns.statMEL]
        self.statMAG = row[Columns.statMAG]
        self.statRNG = row[Columns.statRNG]
        self.soulHarvest = row[Columns.soulHarvest]
        
        self.lifeLevel1 = row[Columns.lifeLevel1]
        self.lifeLevel2 = row[Columns.lifeLevel2]
        self.lifeLevel3 = row[Columns.lifeLevel3]
        self.reviveDamage = row[Columns.reviveDamage]
        
        self.canLevel = row[Columns.canLevel] as! Int64 == 0 ? false : true
        self.multipleAllowed = row[Columns.multipleAllowed] as! Int64 == 0 ? false : true
        
        self.cardBasename = row[Columns.cardBasename]
        self.cardAmount = row[Columns.cardAmount]
    }
    
    mutating func loadAttacks(attacks: [AttackModel]) {
        self.attacks = attacks.filter({ (a) -> Bool in
            return ((a.cardRefType == .character) && (a.cardRefId == self.id))
        })
    }

    public var hashValue: Int {
        return id.hashValue;
    }
    
    static func == (lhs: CharacterModel, rhs: CharacterModel) -> Bool {
        return
            lhs.id.hashValue == rhs.id.hashValue
    }
}

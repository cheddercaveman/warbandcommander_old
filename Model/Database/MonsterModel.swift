//
//  MonsterModel.swift
//  Judgement
//
//  Created by Oliver Hauth on 22.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation
import GRDB

struct MonsterModel : CardBase, RowConvertible, TableMapping, Hashable, Equatable {
    static var databaseTableName: String { return "masMonster" }
    static let databaseSelection: [SQLSelectable] = [AllColumns(), Column.rowID]
    
    enum Columns {
        static let id = Column("rowid")
        static let name = Column("name")
        static let trait = Column("traits")
        static let statMOV = Column("stat_MOV")
        static let statAGI = Column("stat_AGI")
        static let statRES = Column("stat_RES")
        static let statMEL = Column("stat_MEL")
        static let statMAG = Column("stat_MAG")
        static let statRNG = Column("stat_RNG")
        static let fateBounty = Column("stat_FateBounty")
        static let life = Column("life")
        static let reviveDamage = Column("reviveDamage")
        static let cardBasename = Column("cardbasename")
        static let cardAmount = Column("cardamount")
    }
    
    
    var id: Int = 0
    var name: String = ""
    var trait: String = ""
    var statMOV: String?
    var statAGI: String?
    var statRES: String?
    var statMEL: String?
    var statRNG: String?
    var statMAG: String?
    var fateBounty: String?
    
    var life: Int = 0
    var reviveDamage: Int = 0

    var cardBasename: String = ""
    var cardAmount: Int = 0

    var attacks: [AttackModel] = []

    init(row: Row) {
        self.id = row[Columns.id]
        
        self.name = row[Columns.name]
        self.trait = row[Columns.trait]
        
        self.statMOV = row[Columns.statMOV]
        self.statAGI = row[Columns.statAGI]
        self.statRES = row[Columns.statRES]
        self.statMEL = row[Columns.statMEL]
        self.statMAG = row[Columns.statMAG]
        self.statRNG = row[Columns.statRNG]
        self.fateBounty = row[Columns.fateBounty]
        
        self.life = row[Columns.life]
        self.reviveDamage = row[Columns.reviveDamage]
        
        self.cardBasename = row[Columns.cardBasename]
        self.cardAmount = row[Columns.cardAmount]
    }
    
    mutating func loadAttacks(attacks: [AttackModel]) {
        self.attacks = attacks.filter({ (a) -> Bool in
            return ((a.cardRefType == .monster) && (a.cardRefId == self.id))
        })
    }
    
    public var hashValue: Int {
        return id.hashValue;
    }
    
    static func == (lhs: MonsterModel, rhs: MonsterModel) -> Bool {
        return
            lhs.id.hashValue == rhs.id.hashValue
    }
}

extension MonsterModel : StatsDataSource {
    func getType() -> CardRefType {
        return .monster
    }
    
    func getMov() -> String? {
        return self.statMOV
    }
    
    func getAgi() -> String? {
        return self.statAGI
    }
    
    func getRes() -> String? {
        return self.statRES
    }
    
    func getMel() -> String? {
        return self.statMEL
    }
    
    func getMag() -> String? {
        return self.statMAG
    }
    
    func getRng() -> String? {
        return self.statRNG
    }
    
    func getExtra() -> String? {
        return self.fateBounty
    }
    
    func getLifeLeft() -> String? {
        return self.getLifeLeft()
    }
}


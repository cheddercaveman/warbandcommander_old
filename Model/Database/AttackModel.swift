//
//  AttackModel.swift
//  Judgement
//
//  Created by Oliver Hauth on 14.01.18.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation
import GRDB

struct AttackModel : RowConvertible, TableMapping, Hashable, Equatable {
    static var databaseTableName: String { return "masAttacks" }
    static let databaseSelection: [SQLSelectable] = [AllColumns(), Column.rowID]
    
    enum Columns {
        static let id = Column("rowid")
        static let cardRefType = Column("cardRefType")
        static let cardRefId = Column("cardRefId")
        static let order = Column("order")
        static let name = Column("name")
        static let type = Column("type")
        static let cost = Column("cost")
        static let range = Column("range")
        static let glanceDamage = Column("glanceDamage")
        static let solidDamage = Column("solidDamage")
        static let critDamage = Column("critDamage")
    }
    
    
    var id: Int = 0
    var cardRefType: CardRefType = .character
    var cardRefId: Int = 0
    var order: Int = 0
    var name: String = ""
    var type: AttackType = .melee
    var cost: String = ""
    var range: String = ""
    var glanceDamage: String = ""
    var solidDamage: String = ""
    var critDamage: String = ""
    
    
    init(row: Row) {
        self.id = row[Columns.id]
        
        self.cardRefType = CardRefType(rawValue: row[Columns.cardRefType])!
        self.cardRefId = row[Columns.cardRefId]
        self.order = row[Columns.order]
        self.name = row[Columns.name]
        self.type = AttackType(rawValue: row[Columns.type])!
        self.cost = row[Columns.cost]
        self.range = row[Columns.range]
        self.glanceDamage = row[Columns.glanceDamage]
        self.solidDamage = row[Columns.solidDamage]
        self.critDamage = row[Columns.critDamage]
    }
    
    public var hashValue: Int {
        return id.hashValue;
    }
    
    static func == (lhs: AttackModel, rhs: AttackModel) -> Bool {
        return
            lhs.id.hashValue == rhs.id.hashValue
    }
}




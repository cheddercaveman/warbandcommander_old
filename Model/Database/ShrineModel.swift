//
//  ShrineModel.swift
//  Judgement
//
//  Created by Oliver Hauth on 27.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation
import GRDB

struct ShrineModel : CardBase, RowConvertible, TableMapping, Hashable, Equatable {
    static var databaseTableName: String { return "masShrines" }
    static let databaseSelection: [SQLSelectable] = [AllColumns(), Column.rowID]
    
    enum Columns {
        static let id = Column("rowid")
        static let name = Column("name")
        static let trait = Column("traits")
        static let cardBasename = Column("cardbasename")
        static let cardAmount = Column("cardamount")
    }
    
    
    var id: Int = 0
    var name: String = ""
    var trait: String = ""
    
    var cardBasename: String = ""
    var cardAmount: Int = 0

    
    init(row: Row) {
        self.id = row[Columns.id]
        
        self.name = row[Columns.name]
        self.trait = row[Columns.trait]
        
        self.cardBasename = row[Columns.cardBasename]
        self.cardAmount = row[Columns.cardAmount]
    }
    
    public var hashValue: Int {
        return id.hashValue;
    }
    
    static func == (lhs: ShrineModel, rhs: ShrineModel) -> Bool {
        return
            lhs.id.hashValue == rhs.id.hashValue
    }
}



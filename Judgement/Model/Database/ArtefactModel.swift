//
//  ArtefactModel.swift
//  Judgement
//
//  Created by Oliver Hauth on 22.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation
import GRDB

struct ArtefactModel : CardBase, FetchableRecord, TableRecord, Hashable, Equatable {
    static var databaseTableName: String { return "Artefacts" }
    static let databaseSelection: [SQLSelectable] = [AllColumns(), Column.rowID]
    
    enum Columns {
        static let id = Column("rowid")
        static let name = Column("name")
        static let trait = Column("traits")
        static let artefactRole = Column("role")
        static let statModified = Column("statModified")
        static let statModifiedAmount = Column("statModifiedAmount")
        static let cardBasename = Column("cardbasename")
        static let cardAmount = Column("cardamount")
    }
    
    
    var id: Int = 0
    var name: String = ""
    var trait: ArtefactTrait = .offense
    
    var statModified: String? = ""
    var statModifiedAmount: Int = 0
    
    var cardBasename: String = ""
    var cardAmount: Int = 0
    
    
    init(row: Row) {
        self.id = row[Columns.id]
        
        self.name = row[Columns.name]
        self.trait = ArtefactTrait(rawValue: row[Columns.trait])!
        
        self.statModified = row[Columns.statModified]
        self.statModifiedAmount = row[Columns.statModifiedAmount]

        self.cardBasename = row[Columns.cardBasename]
        self.cardAmount = row[Columns.cardAmount]
    }
    
    public var hashValue: Int {
        return id.hashValue;
    }
    
    static func == (lhs: ArtefactModel, rhs: ArtefactModel) -> Bool {
        return
            lhs.id.hashValue == rhs.id.hashValue
    }
}




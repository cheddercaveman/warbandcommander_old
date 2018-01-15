//
//  DbMaster.swift
//  Judgement
//
//  Created by Oliver Hauth on 24.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation
import GRDB


class DatabaseService {
    static let sharedInstance: DatabaseService = DatabaseService()
    
    let MasterDataDb: String
    let MasterDataQueue: DatabaseQueue?
    
    var Characters: [CharacterModel]?
    var Monsters: [MonsterModel]?
    var Shrines: [ShrineModel]?
    var Artefacts: [ArtefactModel]?
    var Attacks: [AttackModel]?

    init() {
        var config = Configuration()
        config.readonly = false
        config.foreignKeysEnabled = true // Default is already true
        config.trace = { print($0) }     // Prints all SQL statements
        config.maximumReaderCount = 5   // The default is 5

        
        self.MasterDataDb = (Bundle.main.resourceURL?.appendingPathComponent("judgement.sqlite"))!.absoluteString

        do {
            self.MasterDataQueue = try DatabaseQueue(path: self.MasterDataDb, configuration: config)
            //self.MasterDataQueue.setupMemoryManagement(in: application)
        }
        catch {
            self.MasterDataQueue = nil
        }

        // Load static data
        do {
            try self.MasterDataQueue?.inDatabase { (db) in
                self.Attacks = try AttackModel
                    .order(AttackModel.Columns.cardRefType, AttackModel.Columns.cardRefId, AttackModel.Columns.order)
                    .fetchAll(db)
            }
        }
        catch
        {}
        do {
            try self.MasterDataQueue?.inDatabase { (db) in
                self.Characters = try CharacterModel
                    .order(CharacterModel.Columns.battlefieldRole, CharacterModel.Columns.name)
                    .fetchAll(db)
            }
            for i in 0 ..< self.Characters!.count {
                self.Characters![i].loadAttacks(attacks: self.Attacks!)
            }
        }
        catch
        {}
        do {
            try self.MasterDataQueue?.inDatabase { (db) in
                self.Monsters = try MonsterModel
                    .order(MonsterModel.Columns.name)
                    .fetchAll(db)
            }
            for i in 0 ..< self.Monsters!.count {
                self.Monsters![i].loadAttacks(attacks: self.Attacks!)
            }
        }
        catch
        {}
        do {
            try self.MasterDataQueue?.inDatabase { (db) in
                self.Shrines = try ShrineModel
                    .order(ShrineModel.Columns.name)
                    .fetchAll(db)
            }
            for var m in self.Monsters! {
                m.loadAttacks(attacks: self.Attacks!)
            }
        }
        catch
        {}
        do {
            try self.MasterDataQueue?.inDatabase { (db) in
                self.Artefacts = try ArtefactModel
                    .order(ArtefactModel.Columns.name)
                    .fetchAll(db)
            }
        }
        catch
        {}
    }
}

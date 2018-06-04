//
//  Settings.swift
//  Judgement
//
//  Created by Oliver Hauth on 16.01.18.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation

class TempSettings {
    private static var _sharedInstance: Dictionary<ScrollPosition, Int>?
    
    static var sharedInstance: Dictionary<ScrollPosition, Int> {
        get {
            if TempSettings._sharedInstance == nil {
                TempSettings._sharedInstance = Dictionary()
                TempSettings._sharedInstance![.rulebookScrollPosition] = 0
                TempSettings._sharedInstance![.tournamentPackScrollPosition] = 0
            }
            return TempSettings._sharedInstance!
        }
        set {
            TempSettings._sharedInstance = newValue
        }
    }
}

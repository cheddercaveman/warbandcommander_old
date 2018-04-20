//
//  Settings.swift
//  Judgement
//
//  Created by Oliver Hauth on 16.01.18.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation

class TempSettings {
    static var sharedInstance: Dictionary<ScrollPosition, Int> = Dictionary()
    
    init() {
        TempSettings.sharedInstance[.rulebookScrollPosition] = 0
        TempSettings.sharedInstance[.tournamentPackScrollPosition] = 0
    }
}

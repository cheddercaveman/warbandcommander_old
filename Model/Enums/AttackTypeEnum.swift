//
//  AttackTypeEnum.swift
//  Judgement
//
//  Created by Oliver Hauth on 14.01.18.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation

let AttackTypeNames: [String] = ["Melee", "Magic", "Range"]

enum AttackType: Int {
    case melee = 0
    case magic = 1
    case range = 2
}

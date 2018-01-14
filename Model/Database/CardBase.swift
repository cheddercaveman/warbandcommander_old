//
//  CardBase.swift
//  Judgement
//
//  Created by Oliver Hauth on 27.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation

protocol CardBase {
    var id: Int { get set }
    var name: String { get set }
    var cardBasename: String { get set }
    var cardAmount: Int { get set }
}

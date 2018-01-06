//
//  CardBase.swift
//  Judgement
//
//  Created by Oliver Hauth on 27.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import Foundation
import GRDB

protocol CardBase {
    var id: Int { get set }
    var name: String { get set }
    var cardBasename: String { get set }
    var cardAmount: Int { get set }
}

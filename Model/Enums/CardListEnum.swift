//
//  CardListEnum.swift
//  Judgement
//
//  Created by Oliver Hauth on 31.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import Foundation

enum CardListType {
    case undefined
    case characterPreview(headline: String, cardCellIdentifier: String, cardCellType: BaseCardCell.Type?)
    case monsterPreview(headline: String, cardCellIdentifier: String, cardCellType: BaseCardCell.Type?)
    case artefactPreview(headline: String, cardCellIdentifier: String, cardCellType: BaseCardCell.Type?)
    case shrinePreview(headline: String, cardCellIdentifier: String, cardCellType: BaseCardCell.Type?)
    case characterSelection(headline: String, cardCellIdentifier: String, cardCellType: BaseCardCell.Type?)
    case monsterSelection(headline: String, cardCellIdentifier: String, cardCellType: BaseCardCell.Type?)
    case offensiveArtefactSelection(headline: String, cardCellIdentifier: String, cardCellType: BaseCardCell.Type?, enableDismiss: Bool, referenceId: Int)
    case defensiveArtefactSelection(headline: String, cardCellIdentifier: String, cardCellType: BaseCardCell.Type?, enableDismiss: Bool, referenceId: Int)
    case shrineSelection(headline: String, cardCellIdentifier: String, cardCellType: BaseCardCell.Type?)
}


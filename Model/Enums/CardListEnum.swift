//
//  CardListEnum.swift
//  Judgement
//
//  Created by Oliver Hauth on 31.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import Foundation

enum CardListType {
    case undefined
    case characterPreview(headline: String, cardCellIdentifier: String, cardCellType: CardCollectionViewCell.Type?)
    case monsterPreview(headline: String, cardCellIdentifier: String, cardCellType: CardCollectionViewCell.Type?)
    case artefactPreview(headline: String, cardCellIdentifier: String, cardCellType: CardCollectionViewCell.Type?)
    case shrinePreview(headline: String, cardCellIdentifier: String, cardCellType: CardCollectionViewCell.Type?)
    case characterSelection(headline: String, cardCellIdentifier: String, cardCellType: CardCollectionViewCell.Type?)
    case monsterSelection(headline: String, cardCellIdentifier: String, cardCellType: CardCollectionViewCell.Type?)
    case offensiveArtefactSelection(headline: String, cardCellIdentifier: String, cardCellType: CardCollectionViewCell.Type?, enableDismiss: Bool, referenceId: Int)
    case defensiveArtefactSelection(headline: String, cardCellIdentifier: String, cardCellType: CardCollectionViewCell.Type?, enableDismiss: Bool, referenceId: Int)
    case shrineSelection(headline: String, cardCellIdentifier: String, cardCellType: CardCollectionViewCell.Type?)
}


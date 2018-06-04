//
//  LargeTitleNavigationController.swift
//  Judgement
//
//  Created by Oliver Hauth on 28.12.17.
//  Copyright © 2018 nogoodname. All rights reserved.
//

import UIKit

class LargeTitleNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

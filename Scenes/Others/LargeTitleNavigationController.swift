//
//  LargeTitleNavigationController.swift
//  Judgement
//
//  Created by Oliver Hauth on 28.12.17.
//  Copyright © 2017 Headblast Oberhausen e.V. All rights reserved.
//

import UIKit

class LargeTitleNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

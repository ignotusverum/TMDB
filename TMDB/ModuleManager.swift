//
//  ModuleManager.swift
//  TMDB
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import MERLin

extension BaseModuleManager: TMDBViewControllerBuilding {
    func searchViewController() -> UISearchController { UISearchController() }
}

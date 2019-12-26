//
//  Searching.swift
//  TMDBFoundation
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import UIKit

public enum SearchingStyle {
    case none
    case fromButton
    case fromSearchBar
    case asTableViewHeader(UITableView)
}

public protocol Searching: class {
    var searchHandler: (SearchHandling & SearchStarting)! { get set }
    var searchStyle: SearchingStyle { get }
}

public protocol SearchHandling {
    var searchController: UISearchController { get }
    
    @discardableResult
    func setupSearchController(for controller: UIViewController & Searching) -> UISearchResultsUpdating?
}

@objc public protocol SearchStarting {
    @objc func beginSearchAction(_ sender: Any)
}

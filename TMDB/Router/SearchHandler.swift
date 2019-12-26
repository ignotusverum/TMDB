//
//  SearchHandler.swift
//  TMDB
//
//  Created by Giuseppe Lanza on 21/03/2018.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import TMDBFoundation
public typealias TMDBSearching = UIViewController & Searching
public typealias TMDBSearchHandling = SearchHandling & SearchStarting

class SearchHandler: NSObject, TMDBSearchHandling, UISearchControllerDelegate {
    var searchController: UISearchController
    var rightBarButtonItems: [UIBarButtonItem]?
    var leftBarButtonItems: [UIBarButtonItem]?
    var titleView: UIView?
    
    weak var controller: TMDBSearching?
    private var shouldRestoreToolBar = false
    
    init(with searchController: UISearchController) {
        self.searchController = searchController
    }
    
    @discardableResult
    func setupSearchController(for controller: TMDBSearching) -> UISearchResultsUpdating? {
        self.controller = controller
        controller.searchHandler = self
        controller.definesPresentationContext = true
        
        searchController.delegate = self
        searchController.searchBar.searchBarStyle = .minimal
        
        var shouldHide = false
        switch controller.searchStyle {
        case .fromButton, .asTableViewHeader:
            shouldHide = true
        case .none, .fromSearchBar: break
        }
        
        searchController.hidesNavigationBarDuringPresentation = shouldHide
        searchController.definesPresentationContext = true
        
        return searchController.searchResultsUpdater
    }
    
    @objc func beginSearchAction(_ sender: Any) {
        guard let controller = controller else { return }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.searchController.searchBar.becomeFirstResponder()
        }
        controller.navigationItem.setHidesBackButton(true, animated: true)
        
        titleView = controller.navigationItem.titleView
        
        controller.navigationItem.searchController = searchController
        
        rightBarButtonItems = controller.navigationItem.rightBarButtonItems
        leftBarButtonItems = controller.navigationItem.leftBarButtonItems
        
        controller.navigationItem.setRightBarButtonItems(nil, animated: true)
        controller.navigationItem.setLeftBarButtonItems(nil, animated: true)
        
        shouldRestoreToolBar = controller.navigationController?.isToolbarHidden == false
        controller.navigationController?.setToolbarHidden(true, animated: true)
        CATransaction.commit()
    }
    
    @objc func willDismissSearchController(_ searchController: UISearchController) {
        guard let controller = controller else { return }
        guard case .fromButton = controller.searchStyle else { return }
        
        CATransaction.begin()
        controller.navigationItem.searchController = nil
        CATransaction.commit()
    }
    
    @objc func didDismissSearchController(_ searchController: UISearchController) {
        guard let controller = controller else { return }
        guard case .fromButton = controller.searchStyle else { return }
        
        CATransaction.begin()
        controller.navigationItem.setHidesBackButton(false, animated: true)
        controller.navigationItem.setRightBarButtonItems(rightBarButtonItems, animated: true)
        controller.navigationItem.setLeftBarButtonItems(leftBarButtonItems, animated: true)
        
        if shouldRestoreToolBar {
            controller.navigationController?.setToolbarHidden(false, animated: true)
        }
        CATransaction.commit()
    }
}

//
//  SearchVC-UISearchExtend.swift
//  PokedexJanvi
//
//  Created by Janvi Shah on 10/1/20.
//

import UIKit

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

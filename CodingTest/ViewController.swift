//
//  ViewController.swift
//  CodingTest
//
//  Created by Marco Gloria on 04/03/25.
//

import UIKit
import Combine

// Define the sections and items
enum Section {
    case main
}

class ViewController: UIViewController, UITableViewDelegate, Storyboarded {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    weak var coordinator: CountryCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        coordinator?.createDatasource()
        coordinator?.setupObservers()
    }

    private func setupTableView() {
        tableView.delegate = self
        searchBar.delegate = self
        let nib = UINib(nibName: "TableViewCellForCountries", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CountryCell")
    }
        
    /// Returns a list of univerties matching given query
    func filteredCountries(query: String) -> [Countries] {
        return self.coordinator?.filteredCountries(query: query) ?? []
    }
    
    private func applySnapshot(_ countries: [Countries]) {
        self.coordinator?.applySnapshot(countries)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Check if the searched text has at least 1 character otherwise show all results
        self.coordinator?.searchBar(searchBar, textDidChange: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.coordinator?.searchBarCancelButtonClicked(searchBar)
    }
}

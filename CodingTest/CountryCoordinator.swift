//
//  CountryCoordinator.swift
//  CodingTest
//
//  Created by Marco Gloria on 05/03/25.
//

import Combine
import UIKit

class CountryCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var datasource: UITableViewDiffableDataSource<Section, Countries>!
    let viewController = ViewController.instantiate()
    let viewModel = CountryViewModel()
    let networkManager = NetworkManager()
    var cancellable: Set<AnyCancellable> = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
        getCountries()
        setupObservers()
    }
    
    private func getCountries() {
        Task {
            await getCountryData()
        }
    }
    
    func getCountryData() async {
        let countries = await networkManager.getCountries()
        // Populate the data source with initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Countries>()
        snapshot.appendSections([.main])
        snapshot.appendItems(countries ?? [])
        await self.datasource.apply(snapshot, animatingDifferences: false)
        let vc = self.viewController
        viewModel.datasource = countries ?? []

        Task {
            await MainActor.run {
                vc.tableView.reloadData()
            }
        }
    }
    
    func setupObservers() {
        networkManager.$netManagerError.sink { [weak self] error in
            if error != nil {
                let errorMessage = error?.localizedDescription ?? "Unknown error"
                let alert = UIAlertController(title: "Error", message: "Error loading data: \(errorMessage)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                DispatchQueue.main.async {
                    self?.viewController.present(alert, animated: true, completion: nil)
                }
            }
        }
        .store(in: &(cancellable))
    }

    func createDatasource() {
        // Create the data source
         datasource = UITableViewDiffableDataSource(tableView: viewController.tableView) { tableView, indexPath, country in
             
             let cell = self.viewController.tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! TableViewCellForCountries
             cell.labelCountryCapital.text = country.capital
             cell.labelCountryCode.text = country.code
             cell.labelCountryName.text = country.name
             cell.labelCountryRegion.text = country.region
             
             return cell
         }
    }

/*    private func loadData() {
        viewModel.loadData()
    } */
    
    func filteredCountries(query: String) -> [Countries] {
        return viewModel.filteredCountries(query: query)
    }

    func applySnapshot(_ countries: [Countries]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Countries>()
        snapshot.appendSections([.main])
        snapshot.appendItems(countries)
        datasource.apply(snapshot, animatingDifferences: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Check if the searched text has at least 1 character otherwise show all results
        guard searchText != "" else {
            applySnapshot(viewModel.datasource)
            return
        }

        applySnapshot(viewModel.filteredCountries(query: searchText))
        viewController.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        applySnapshot(viewModel.datasource)
        searchBar.text = ""
    }

}

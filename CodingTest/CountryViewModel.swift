//
//  CountryViewModel.swift
//  CodingTest
//
//  Created by Marco Gloria on 05/03/25.
//

import Foundation
import Combine

class CountryViewModel {
    let networkManager = NetworkManager()
    var datasource: [Countries] = []
    
    init () {
    }
    
    func filteredCountries(query: String) -> [Countries] {
        let lcQuery = query.lowercased()
        let names = datasource.filter {
            let name = $0.name?.lowercased() ?? ""
            return name.contains(lcQuery)
        }
        let capital = datasource.filter {
            let capital = $0.capital?.lowercased() ?? ""
            return capital.contains(lcQuery)
        }

        return names.count > capital.count ? names : capital
    }

    func countriesCount() -> Int {
        return datasource.count
    }
}

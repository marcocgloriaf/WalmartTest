//
//  NetworkManager.swift
//  CodingTest
//
//  Created by Marco Gloria on 04/03/25.
//

import Combine
import Foundation

/// This extension is copyright of Hacking with swift website
extension URLSession {
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws  -> T {
        let (data, _) = try await data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy

        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}

struct Countries: Codable, Hashable {
    //let id: Int
    let name: String?
    let region: String?
    let code: String?
    let capital: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }
}

class NetworkManager {
    @Published var netManagerError: Error?
    init () { }
    
    func getCountries() async -> [Countries]? {
        do {
            let urlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
            guard let url = URL(string: urlString) else {
                fatalError("Invalid URL: \(urlString)")
            }
            
            // Create a custom URLSession and decode a Double array from that
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            let session = URLSession(configuration: config)
            
            let countries = try await session.decode([Countries].self, from: url)
            return countries
            
        } catch {
            //handle error
            print("error in reading countries ")
            print("Download error: \(error.localizedDescription)")
            netManagerError = error
        }
        return nil
    }
}

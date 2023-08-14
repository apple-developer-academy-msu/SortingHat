//
//  NetworkManager.swift
//  SortingHat
//
//  Created by Kevin Buchholz on 8/2/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetch <T: Decodable>(from urlRequest: URLRequest) async throws -> T {
        let urlSession = URLSession.shared
        
        let (data, _) = try await urlSession.data(for: urlRequest)
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        return result
        
    }
}

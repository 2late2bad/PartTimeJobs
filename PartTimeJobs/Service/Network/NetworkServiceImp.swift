//
//  JobNetworkServiceImp.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 04.11.2023.
//

import Foundation

final class NetworkServiceImp: NetworkService {
    
    private let baseUrl: String
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(baseUrl: String,
         decoder: JSONDecoder = JSONDecoder(),
         session: URLSession = URLSession.shared) {
        self.decoder = decoder
        self.session = session
        self.baseUrl = baseUrl
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func request<T: Decodable>(_ httpMethod: HttpMethod) async throws -> T {
        guard let url = URL(string: baseUrl) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard response.statusCode == 200 else {
            throw NetworkError.invalidStatusCode(response.statusCode)
        }
        
        do {
            let parse = try decoder.decode(T.self, from: data)
            return parse
        } catch {
            throw NetworkError.invalidDecoding
        }
    }
}

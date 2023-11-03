//
//  JobNetworkServiceImp.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 04.11.2023.
//

import Foundation

final class JobNetworkServiceImp: JobNetworkService {
    
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

    func fetchJobs() async throws -> [Job] {
        guard let url = URL(string: baseUrl) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        
        do {
            let jobs = try decoder.decode([Job].self, from: data)
            return jobs
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}

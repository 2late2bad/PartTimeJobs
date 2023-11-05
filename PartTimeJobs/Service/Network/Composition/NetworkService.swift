//
//  JobNetworkService.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 04.11.2023.
//

protocol NetworkService {
    func request<T: Decodable>(_ httpMethod: HttpMethod) async throws -> T
}

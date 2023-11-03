//
//  JobNetworkService.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 04.11.2023.
//

protocol JobNetworkService {
    func fetchJobs() async throws -> [Job]
}

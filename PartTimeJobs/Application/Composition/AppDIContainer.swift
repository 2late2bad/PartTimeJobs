//
//  AppDIContainer.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

struct AppDIContainer {
    
    // MARK: - Network Container
    let jobNetworkService = NetworkServiceImp(baseUrl: R.API.jobs)
}

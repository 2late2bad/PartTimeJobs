//
//  AppDIContainer.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

struct AppDIContainer {
    
    // Network Container
    let jobNetworkService = JobNetworkServiceImp(baseUrl: R.API.jobs)
}

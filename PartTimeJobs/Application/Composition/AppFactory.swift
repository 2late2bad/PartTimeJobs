//
//  AppFactory.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

struct AppFactory {
    
    let appDIContainer: AppDIContainer
    
    func makeJobListCoordinator(
        navigation: UINavigationController
    ) -> Coordinator {
        let jobListFactory = JobListFactory(appDIContainer: appDIContainer)
        return JobListCoordinator(navigation: navigation, factory: jobListFactory)
    }
}

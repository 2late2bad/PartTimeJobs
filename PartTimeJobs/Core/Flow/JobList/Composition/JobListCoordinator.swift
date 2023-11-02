//
//  JobListCoordinator.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

final class JobListCoordinator: Coordinator {
    
    var navigation: UINavigationController
    var factory: JobListFactory
    
    init(
        navigation: UINavigationController,
        factory: JobListFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeJobListViewController()
        navigation.pushViewController(controller, animated: false)
    }
}

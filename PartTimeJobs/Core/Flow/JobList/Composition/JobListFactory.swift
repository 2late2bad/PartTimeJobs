//
//  JobListFactory.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

struct JobListFactory {
    
    let appDIContainer: AppDIContainer
    
    func makeJobListViewController() -> UIViewController {
        let controller = JobListViewController()
        let presenter = JobListPresenter(view: controller,
                                         model: JobListModel(),
                                         networkService: appDIContainer.jobNetworkService)
        controller.presenter = presenter
        return controller
    }
}

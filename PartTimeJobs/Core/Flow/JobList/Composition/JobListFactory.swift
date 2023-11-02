//
//  JobListFactory.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

struct JobListFactory {
    
    let appDIContainer: AppDIContainer?
    
    func makeJobListViewController() -> UIViewController {
        JobListViewController()
    }
}

//
//  AppCoordinator.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var navigation: UINavigationController
    var childCoordinators: [Coordinator] = []
    var window: UIWindow?
    var factory: AppFactory?
    
    init(window: UIWindow?, navigation: UINavigationController, factory: AppFactory?) {
        self.window = window
        self.navigation = navigation
        self.factory = factory
        if #available(iOS 15, *) {
            let navBarApp = UINavigationBarAppearance()
            navBarApp.configureWithOpaqueBackground()
            navBarApp.backgroundColor = R.Colors.navBarBack.ui
            navBarApp.shadowColor = .clear
            UINavigationBar.appearance().scrollEdgeAppearance = navBarApp
        }
    }
    
    func start() {
        configWindow()
        startJobListCoordinator()
    }
    
    private func configWindow() {
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    private func startJobListCoordinator() {
        let jobListCoordinator = factory?.makeJobListCoordinator(navigation: navigation)
        addChild(jobListCoordinator)
    }
}

extension AppCoordinator: ParentCoordinator {}

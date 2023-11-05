//
//  JobListViewProtocol.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 04.11.2023.
//

protocol JobListViewProtocol: AnyObject {
    func updateButton(with title: String?, isActive: Bool)
    func showAlert(title: String, message: String)
    func updateCollection(with data: SectionData)
}

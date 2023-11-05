//
//  JobListModel.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import Foundation

struct JobListModel {
    
    // MARK: - Public property
    var allJobsData: SectionData { allJobSection }
    
    var allJobs: [Job] {
        allJobSection.values.map { item -> Job in
            switch item {
            case .jobs(let job):
                return job
            }
        }
    }
    
    var selectedJobsById: Set<String> = Set() {
        didSet {
            UserDefaults.selectedID = Array(selectedJobsById)
            updatePaths()
        }
    }
    
    // MARK: - Private property
    private var allJobSection: SectionData = .init(key: .jobs, values: [], selectedPath: [])
    
    // MARK: - Init
    init() {
        selectedJobsById = Set(UserDefaults.selectedID)
    }
    
    // MARK: - Public methods
    mutating func updateJobs(_ jobs: [Job]) {
        let sectionItems = jobs.map { SectionItem.jobs($0) }
        allJobSection.values = sectionItems
        updateID()
    }
    
    // MARK: - Private methods
    private mutating func updatePaths() {
        var newSelectedPaths: [IndexPath] = []
        
        for (index, job) in allJobs.enumerated() {
            if selectedJobsById.contains(job.id) {
                let section = Section.jobs.rawValue
                newSelectedPaths.append(IndexPath(item: index, section: section))
            }
        }
                
        allJobSection.selectedPath = newSelectedPaths
    }
    
    private mutating func updateID() {
        var newSelectID: Set<String> = Set()
        
        for job in allJobs {
            if selectedJobsById.contains(job.id) {
                newSelectID.insert(job.id)
            }
        }
                
        selectedJobsById = newSelectID
    }
}

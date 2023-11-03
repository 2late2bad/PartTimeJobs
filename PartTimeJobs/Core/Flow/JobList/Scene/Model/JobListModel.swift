//
//  JobListModel.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import Foundation

struct Job: Decodable {
    let id: String
    let profession: String
    let employer: String
    let salary: Double
    let date: Date
    let logo: String?
}

extension Job: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Job, rhs: Job) -> Bool {
        return lhs.id == rhs.id
    }
}

struct JobListModel {
    
    // MARK: - Public property
    var jobList: [Job] { privateJobList }
    
    // MARK: - Private property
    private var privateJobList: [Job] = [] {
        didSet {
            
        }
    }
    
    // MARK: - Init
    init() {}
    
    // MARK: - Mutating methods
    mutating func addJob(_ job: Job) {
        privateJobList.append(job)
    }
    
    mutating func removeJob(at index: Int) {
        privateJobList.remove(at: index)
    }
    
    mutating func updateJobs(_ jobs: [Job]) {
        privateJobList = jobs
    }
}

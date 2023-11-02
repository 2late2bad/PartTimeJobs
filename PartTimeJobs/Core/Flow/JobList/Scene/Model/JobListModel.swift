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

struct JobListModel {
    
    var jobList: [Job] { privateJobList }
    
    private var privateJobList: [Job] = [] {
        didSet {
            
        }
    }
    
    init() {}
    
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

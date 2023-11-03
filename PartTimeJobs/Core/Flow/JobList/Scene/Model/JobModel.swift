//
//  JobModel.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 03.11.2023.
//

import Foundation

typealias Job = JobModel

struct JobModel: Decodable {
    let id: String
    let profession: String
    let employer: String
    let salary: Double
    let date: Date
    let logo: String?
}

extension JobModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Job, rhs: Job) -> Bool {
        return lhs.id == rhs.id
    }
}

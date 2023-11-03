//
//  JobListModel.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import Foundation

// TODO: -
enum Section: Hashable {
    case jobs
}

enum SectionItem: Hashable {
    case jobs(Job)
}

struct SectionData {
    var key: Section
    var values: [SectionItem]
}

struct JobListModel {
    
    var allJobs: SectionData { allJobSection }
    var filterJobs: SectionData { filterJobSection }
    //var selectedPaths: [IndexPath] = []
    
    private var allJobSection: SectionData = .init(key: .jobs, values: [])
    private var filterJobSection: SectionData = .init(key: .jobs, values: [])
    
    init() {
        // TODO: - MOCK DATA
        allJobSection =
        SectionData(key: .jobs, values: [
            .jobs(.init(id: "1", profession: "Грузчик", employer: "Озон", salary: 1600, date: .now, logo: nil)),
            .jobs(.init(id: "2", profession: "Монтажник", employer: "ОЗОН", salary: 200, date: .now, logo: nil)),
            .jobs(.init(id: "3", profession: "Разработчик", employer: "Пятерочка", salary: 14400, date: .now, logo: nil)),
            .jobs(.init(id: "4", profession: "Строитель", employer: "Шелф", salary: 1200, date: .now, logo: nil)),
            .jobs(.init(id: "5", profession: "Монтажник", employer: "ОЗОН", salary: 200.12, date: .now, logo: nil)),
            .jobs(.init(id: "6", profession: "Разработчик", employer: "Пятерочка", salary: 14400, date: .now, logo: nil)),
            .jobs(.init(id: "7", profession: "Строитель", employer: "Шелф", salary: 1200.00, date: .now, logo: nil)),
            .jobs(.init(id: "8", profession: "Монтажник", employer: "ОЗОН", salary: 200, date: .now, logo: nil)),
            .jobs(.init(id: "9", profession: "Разработчик", employer: "Пятерочка", salary: 14400, date: .now, logo: nil)),
            .jobs(.init(id: "10", profession: "Коп", employer: "Пятерочка", salary: 0.01, date: .now, logo: nil)),
            .jobs(.init(id: "11", profession: "Копр", employer: "Пятерочка", salary: 14400, date: .now, logo: nil)),
            .jobs(.init(id: "12", profession: "Копро", employer: "Пятерочка", salary: 5555.55, date: .now, logo: nil))
        ])
    }
    
    mutating func updateJobs(_ jobs: [Job]) {
        let sectionItems = jobs.map { SectionItem.jobs($0) }
        allJobSection.values = sectionItems
    }
    
    mutating func updateFilterJobs(_ jobs: [Job]) {
        let sectionItems = jobs.map { SectionItem.jobs($0) }
        filterJobSection.values = sectionItems
    }
}

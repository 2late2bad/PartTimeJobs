//
//  SectionData.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 04.11.2023.
//

import Foundation

enum Section: Int, CaseIterable {
    case jobs
}

enum SectionItem: Hashable {
    case jobs(Job)
}

struct SectionData {
    var key: Section
    var values: [SectionItem]
    var selectedPath: [IndexPath]
}

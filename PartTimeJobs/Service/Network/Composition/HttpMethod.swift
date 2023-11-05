//
//  HttpMethod.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 04.11.2023.
//

// MARK: - HttpMethod
enum HttpMethod: String {
    case get
    case post
    case put
    case delete
    
    var method: String { rawValue.uppercased() }
}

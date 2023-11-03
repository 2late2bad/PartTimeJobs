//
//  NetworkError.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 03.11.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse(code: Int)
    case decodingFailed
}

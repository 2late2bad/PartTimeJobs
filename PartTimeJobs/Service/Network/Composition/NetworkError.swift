//
//  NetworkError.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 03.11.2023.
//

enum NetworkError: Error {
    case invalidResponse
    case invalidStatusCode(Int)
    case invalidDecoding
    case invalidURL
    
    var message: String {
        switch self {
        case .invalidResponse:
            return "Нет ответа от сервера"
        case .invalidStatusCode(let code):
            return "Ответ от сервера: \(code)"
        case .invalidDecoding:
            return "Не получилось декодировать"
        case .invalidURL:
            return "Некорректный URL"
        }
    }
}

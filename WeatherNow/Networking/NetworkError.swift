//
//  NetworkError.swift
//  WeatherNow
//
//  Created by CHUBBY on 2022/06/21.
//

import Foundation

enum NetworkError: Error {
    case invalidAPIKey
    case invalidQueryParameters
    case surpassingLimitOfAPICalls
    case serverError
    
    var message: String {
        switch self {
        case .invalidAPIKey:
            return "API Key가 아직 활성화되지 않았거나 유효하지 않은 API key입니다."
        case .invalidQueryParameters:
            return "Query parameter를 다시 확인해주세요."
        case .surpassingLimitOfAPICalls:
            return "API 호출 횟수 한도를 초과했습니다."
        case .serverError:
            return "Server 에러가 발생했습니다."
        }
    }
}

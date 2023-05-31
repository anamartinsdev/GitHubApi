//
//  ReachabilityModel.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation

enum ReachabilityType: CustomStringConvertible {
    case wwan
    case wiFi
    
    var description: String {
        switch self {
            case .wwan: return "WWAN"
            case .wiFi: return "WiFi"
        }
    }
}

enum ReachabilityStatus: CustomStringConvertible  {
    case offline
    case online(ReachabilityType)
    case unknown
    
    var description: String {
        switch self {
            case .offline: return "Offline"
            case .online(let type): return "Online (\(type))"
            case .unknown: return "Unknown"
        }
    }
}

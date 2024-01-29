//
//  RepositoriesNetworking.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 30/11/23.
//

import Foundation
import Alamofire

enum RepositoriesNetworking {
    case postRequestSignature(establishData: Dictionary<AnyHashable, Any>)
}

extension RepositoriesNetworking: TargetType {
    
    var baseURL: String {
        switch self {
        default:
            return Constants.BASE_URL
        }
    }
    
    var path: String {
        switch self {
        case .postRequestSignature:
            return "/signature/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postRequestSignature:
            return .post
        }
    }
    
    var task: HttpTask {
        switch self {
        case .postRequestSignature(let establish):
            return .requestParameters(parameters: establish as! [String: Any], encoding: JSONEncoding())
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
    
}

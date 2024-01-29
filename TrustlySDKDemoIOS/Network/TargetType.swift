//
//  TargetType.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 30/11/23.
//

import Foundation
import Alamofire

protocol TargetType {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var task: HttpTask {get}
    var headers: [String: String]? {get}
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HttpTask {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

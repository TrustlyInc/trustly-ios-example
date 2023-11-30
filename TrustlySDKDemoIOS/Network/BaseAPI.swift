//
//  BaseAPI.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 30/11/23.
//

import Foundation
import Alamofire

class BaseAPI<T:TargetType> {
    
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completionHandler:@escaping (Result<M, NSError>)-> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters = buildParams(task: target.task)

        
        AF.request(target.baseURL + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers)
            .responseDecodable(of: responseClass) {(response) in
                
                switch response.result {
                case .success(let item):
                    completionHandler(.success(item))
                    
                case .failure(let error):
                    completionHandler(.failure(NSError()))
                }
                
        }
    }
    
    func fetchData(target: T, completionHandler:@escaping (Result<String, NSError>)-> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters = buildParams(task: target.task)
        
        AF.request(target.baseURL + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers)
            .responseString {(response) in
                
                switch response.result {
                case .success(let item):
                    completionHandler(.success(item))
                    
                case .failure(let error):
                    completionHandler(.failure(NSError()))
                }
            
        }
    }
    
    
    private func buildParams(task: HttpTask) -> ([String: Any], ParameterEncoding){
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}

//
//  JSONUtils.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 04/07/23.
//

import Foundation


func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}


func parse<T: Codable>(jsonData: Data) -> T? {
    do {
        let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}

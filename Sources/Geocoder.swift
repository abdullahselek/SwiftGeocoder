//
//  Geocoder.swift
//  SwiftGeocoder
//
//  Created by Abdullah Selek on 23/04/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

import Foundation

open class Geocoder {

    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    open func geocodeAddress(address: String, completion: @escaping (_ result: [String: AnyObject]?, _ error: Error?) -> Void) {
        if apiKey.isEmpty {
            assert(false, "You should set an api key before making a request!")
        }
        let todoEndpoint: String = "https://maps.googleapis.com/maps/api/geocode/json?address=\(urlEncode(url: address))&key=\(apiKey)"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let responseData = data else {
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    return
                }
                completion(json, nil)
            } catch  {
                let error = NSError(domain: "error trying to convert data to JSON", code: 0, userInfo: nil)
                completion(nil, error as Error)
            }
        }
        task.resume()
    }

    internal func urlEncode(url: String) -> String {
        return url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }

}

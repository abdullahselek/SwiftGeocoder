//
//  Geocoder.swift
//  SwiftGeocoder
//
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2017 Abdullah Selek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
        makeRequest(url: url, completion: completion)
    }

    open func reverseGeocode(latitude: Double,
                             longitude: Double,
                             completion: @escaping (_ result: [String: AnyObject]?, _ error: Error?) -> Void) {
        if apiKey.isEmpty {
            assert(false, "You should set an api key before making a request!")
        }
        let todoEndpoint: String = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=\(apiKey)"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        makeRequest(url: url, completion: completion)
    }

    internal func urlEncode(url: String) -> String {
        return url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }

    internal func makeRequest(url: URL, completion: @escaping (_ result: [String: AnyObject]?, _ error: Error?) -> Void) {
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

}

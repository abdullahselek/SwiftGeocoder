//
//  GeocoderTests.swift
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

import Quick
import Nimble
import OHHTTPStubs

@testable import SwiftGeocoder;

class GeocoderTests: QuickSpec {
    
    override func spec() {
        var geocoder: Geocoder!
        let address = "Brandenburger Tor"
        beforeEach {
            geocoder = Geocoder(apiKey: "A")
        }
        describe("GeocoderTests") {
            context("-geocodeAddress", {
                it("should return a dictionary", closure: {
                    stub(condition: isMethodGET()) { request in
                        let obj = ["key1":"value1", "key2": ["value2A","value2B"]] as [String : Any]
                        return OHHTTPStubsResponse(jsonObject: obj, statusCode: 200, headers: nil)
                    }
                    let expectation = self.expectation(description: "Geocoder expectation")
                    geocoder.geocodeAddress(address: address, completion: { (result, error) in
                        expect(result).notTo(beNil())
                        expect(error).to(beNil())
                        expectation.fulfill()
                    })
                    self.waitForExpectations(timeout: 5.0, handler: nil)
                })
            })
            context("-reverseGeocode", {
                it("should return a dictionary", closure: {
                    stub(condition: isMethodGET()) { request in
                        let obj = ["key1":"value1", "key2": ["value2A","value2B"]] as [String : Any]
                        return OHHTTPStubsResponse(jsonObject: obj, statusCode: 200, headers: nil)
                    }
                    let expectation = self.expectation(description: "Geocoder expectation")
                    geocoder.reverseGeocode(latitude: 10.0, longitude: 11.0, completion: { (result, error) in
                        expect(result).notTo(beNil())
                        expect(error).to(beNil())
                        expectation.fulfill()
                    })
                    self.waitForExpectations(timeout: 5.0, handler: nil)
                })
            })
        }
        afterEach {
            OHHTTPStubs.removeAllStubs()
        }
    }
    
}

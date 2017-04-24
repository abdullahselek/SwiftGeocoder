//
//  GeocoderTests.swift
//  SwiftGeocoder
//
//  Created by Abdullah Selek on 23/04/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

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
        }
    }
    
}

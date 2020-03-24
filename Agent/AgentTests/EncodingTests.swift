//
//  EncodingTests.swift
//  AgentTests
//
//  Created by Tian Tong on 3/24/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import XCTest
@testable import Agent

class EncodingTests: XCTestCase {
    
    func testEncodePath() {
        let base = "https://www.ttdp.com"
        let path = "/path"
        let path2 = "path"
        
        do {
            let encodedURL = try Encoding.encode(base: base, path: path)
            let encodedURL2 = try Encoding.encode(base: base, path: path2)
            
            XCTAssertEqual(encodedURL.absoluteString, "https://www.ttdp.com/path")
            XCTAssertEqual(encodedURL2.absoluteString, "https://www.ttdp.com/path")
        } catch {
            XCTFail()
        }
    }
    
    func testEncodingPathWithQueryString() {
        let base = "https://www.ttdp.com"
        let path = "path?hello=1&world=2&str=hello world"
        
        do {
            let encodedURL = try Encoding.encode(base: base, path: path)
            XCTAssertEqual(encodedURL.absoluteString, "https://www.ttdp.com/path?hello=1&world=2&str=hello%20world")
        } catch {
            XCTFail()
        }
    }
    
    func testEncodePathWithQueryStringWithQuerys() {
        let base = "https://www.ttdp.com"
        let path = "path?hello=1&world=2"
        let querys = ["str": "hello world"]
        
        do {
            let encodedURL = try Encoding.encode(base: base, path: path, querys: querys)
            XCTAssertEqual(encodedURL.absoluteString, "https://www.ttdp.com/path?hello=1&world=2&str=hello%20world")
        } catch {
            XCTFail()
        }
    }
    
    func testEncodePathWithQuerys() {
        let base = "https://www.ttdp.com"
        let path = "path"
        let querys = ["str": "hello world"]
        
        do {
            let encodedURL = try Encoding.encode(base: base, path: path, querys: querys)
            XCTAssertEqual(encodedURL.absoluteString, "https://www.ttdp.com/path?str=hello%20world")
        } catch {
            XCTFail()
        }
    }
    
}

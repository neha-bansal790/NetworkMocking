//
//  ProfileTests.swift
//  URLSessionUnitTestTests
//
//  Created by B0203948 on 03/01/21.
//

import XCTest
@testable import URLSessionUnitTest

class ProfileTests: XCTestCase {
    
    var session: URLSession!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        setupSession()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        super.tearDown()
    }
    
    func setupSession() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [NetworkMock.self]
        session = URLSession(configuration: configuration)
    }
    
    func testAPI_GetPhotosWithMock_PhotosObjectShouldFetched() throws {
        let profileApi = ProfileApi(session: session)
        
        let mockData = Photo(farm: 1, server: "neha", id: "123", secret: "1234")
        let data = try JSONEncoder().encode([mockData])
        
        NetworkMock.requestHandler = { request in
            return (HTTPURLResponse(), data)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        profileApi.getProfile { (photos) in
            if let firstObject = photos.first {
                XCTAssertEqual(firstObject.id, "123")
                expectation.fulfill()
            }
            
        }
        wait(for: [expectation], timeout: 1)
    }
    
    
}

//
//  NetworkMock.swift
//  URLSessionUnitTestTests
//
//  Created by B0203948 on 03/01/21.
//

import Foundation

class NetworkMock: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = NetworkMock.requestHandler else {
            return
        }
        do {
          let (resposne, data) = try handler(request)
          client?.urlProtocol(self, didReceive: resposne, cacheStoragePolicy: .notAllowed)
          client?.urlProtocol(self, didLoad: data)
          client?.urlProtocolDidFinishLoading(self)
        } catch let error {
          client?.urlProtocol(self, didFailWithError: error)
        }
        
    }
    
    override func stopLoading() {
        
    }
    
}


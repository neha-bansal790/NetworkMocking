//
//  ProfileAPI.swift
//  URLSessionUnitTest
//
//  Created by B0203948 on 03/01/21.
//

import Foundation
struct Photos:Codable {
    var photo:[Photo]
}

struct Photo:Codable {
    var farm:Int
    var server:String
    var id:String
    var secret:String

}

class ProfileApi {
    
    var urlSession : URLSession
    let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text=Tesla&page=1")!
    
    init(session: URLSession = .shared) {
        self.urlSession = session
    }
    
    
    func getProfile(completion: @escaping ([Photo]) -> Void) {
       urlSession.dataTask(with: url) { (data, response, error) in
            do {
                if let dataWrapped = data {
                    let photos = try JSONDecoder().decode([Photo].self, from: dataWrapped)
                    completion(photos)
                }
            }catch {
                completion([])
            }
       }.resume()
       
    }
    
}

//
//  ServerLogic.swift
//  API+Generics_Codable
//
//  Created by Kashif Jilani on 5/12/20.
//  Copyright © 2020 Kashif Jilani. All rights reserved.
//

import Foundation

protocol PostProvider {
  func getSampleEvents(completion: @escaping((Result<[Post], APIError>) -> Void))
}

class PostProviderApi: PostProvider {
  
  private let postbaseURL = "https://jsonplaceholder.typicode.com"
  private enum EndPoint: String {
    case postRandom = "/posts"
  }
  
  private enum Method: String {
    case GET
  }
  
  func getSampleEvents(completion: @escaping ((Result<[Post], APIError>) -> Void)) {
    self.request(baseURL: postbaseURL,
                      endPoint: .postRandom,
                      method: .GET,
                      completion: completion)
  }
  
  private func request<T: Codable>(baseURL: String,
                                        endPoint: EndPoint,
                                        method: Method,
                                        completion: @escaping((Result<[T], APIError>) -> Void)) {
    
    let path = "\(baseURL)\(endPoint.rawValue)"
    guard let url = URL(string: path)
      else { completion(.failure(.internalError)); return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "\(method)"
    request.allHTTPHeaderFields = ["Content-Type": "application/json"]
    
    self.callWith(with: request, completion: completion)
  }
  
  private func callWith<T: Codable>(with request: URLRequest,
                                    completion: @escaping((Result<[T], APIError>) -> Void)) {
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard error == nil
        else { completion(.failure(.serverError)); return }
      do {
        guard let data = data
          else { completion(.failure(.serverError)); return }
        let object = try JSONDecoder().decode([T].self, from: data)
        completion(Result.success(object))
      } catch {
        completion(Result.failure(.parsingError))
      }
    }
    dataTask.resume()
  }
  
}

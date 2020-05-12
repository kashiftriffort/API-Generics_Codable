//
//  Model.swift
//  API+Generics_Codable
//
//  Created by Kashif Jilani on 5/12/20.
//  Copyright © 2020 Kashif Jilani. All rights reserved.
//

import Foundation

struct Post: Codable {
  let id: Int?
  let title: String?
  let body: String?
  let userId: Int?
}

enum APIError: Error {
  case internalError
  case serverError
  case parsingError
}

//
//  ViewController.swift
//  API+Generics_Codable
//
//  Created by Kashif Jilani on 5/12/20.
//  Copyright © 2020 Kashif Jilani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    //Calling Server and showing data
    
    let postProvider: PostProvider = PostProviderApi()
    postProvider.getSampleEvents {
      switch $0 {
      case .failure:
        print("failed items")
      case let .success(fact):
        print(fact.map({ $0.title ?? "" }))
        print(fact.count)
      }
    }
  }
}


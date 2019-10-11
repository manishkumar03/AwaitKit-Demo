//
//  Helpers.swift
//  AwaitKitDemo
//
//  Created by Manish Kumar on 2019-10-11.
//  Copyright © 2019 Manish Kumar. All rights reserved.
//

import UIKit
import AwaitKit
import PromiseKit

class Helpers: NSObject {
  
  // Fetch the complete json containing user details
  static func fetchUserDetails() -> Promise<String> {
    
    return Promise { seal in
      let userUrl = URL(string: "https://api.randomuser.me")!
      
      let task = URLSession.shared.dataTask(with: userUrl) { (data, response, error) in
        let randomUsers = try? JSONDecoder().decode(RandomUsers.self, from: data!)
        let profilePictureUrl = randomUsers?.results[0].picture.large
        print(profilePictureUrl!)
        seal.fulfill(profilePictureUrl!)
      }
      
      task.resume()
    }
  }
  
  // Fetch the user profile picture
  static func fetchUserImage(profileImageLocation: String) -> Promise<UIImage> {
    
    return Promise { seal in
      let profileImageUrl = URL(string: profileImageLocation)!
      
      let task = URLSession.shared.dataTask(with: profileImageUrl) { (data, response, error) in
        let profileImage = UIImage(data: data!)
        seal.fulfill(profileImage!)
      }
      
      task.resume()
    }
  }  
  
}

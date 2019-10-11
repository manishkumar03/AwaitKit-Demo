//
//  ViewController.swift
//  AwaitKitDemo
//
//  Created by Manish Kumar on 2019-10-11.
//  Copyright © 2019 Manish Kumar. All rights reserved.
//

import UIKit
import AwaitKit
import PromiseKit

class ViewController: UIViewController {
  @IBOutlet weak var profileImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("Step 1: Going to fetch user details")
    let profileImageLocation = try! await(Helpers.fetchUserDetails())
    print("Step 2: Fetched user details")
    
    print("Step 3: Going to fetch profile picture")
    let profileImage = try! await(Helpers.fetchUserImage(profileImageLocation: profileImageLocation))
    print("Step 4: Fetched profile picture")
    
    profileImageView.image = profileImage
  }
}


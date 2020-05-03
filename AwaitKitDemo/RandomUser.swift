//
//  RandomUser.swift
//  AwaitKitDemo
//
//  Created by Manish Kumar on 2019-10-11.
//  Copyright © 2019 Manish Kumar. All rights reserved.
//

import Foundation

struct RandomUsers: Decodable {
    let results: [RandomUser]
}

struct RandomUser: Decodable {
    let picture: UserPicture
}

struct UserPicture: Decodable {
    let medium: String
    let large: String
}

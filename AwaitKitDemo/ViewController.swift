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
    let useFirstMethod = true

    override func viewDidLoad() {
        super.viewDidLoad()

        if useFirstMethod {
            fetchUsingAwaitKit()
        } else {
            fetchUsingExtension()
        }
    }

    /* Using AwaitKit */
    func fetchUsingAwaitKit() -> Void {
        let profileImageLocation = try! await(Helpers.fetchUserDetails())
        let profileImage = try! await(Helpers.fetchUserImage(profileImageLocation: profileImageLocation))
        profileImageView.image = profileImage
    }

    /* The following method uses extensions provided by PromiseKit. */
    func fetchUsingExtension() -> Void {
        let userUrl = URL(string: "https://api.randomuser.me")!

        URLSession.shared.dataTask(.promise, with: userUrl).validate()
            .compactMap { try JSONDecoder().decode(RandomUsers.self, from: $0.data) }
            .map { $0.results[0].picture.large}
            .then { URLSession.shared.dataTask(.promise, with: URL(string: $0)!).validate() }
            .compactMap { UIImage(data: $0.data) }
            .done { self.profileImageView.image = $0}
            .catch { print ($0.localizedDescription)}
    }
}


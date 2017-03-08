//
//  GithubRepository.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubRepository {
    
    let fullName: String
    var htmlURL: URL?
    let repositoryID: String
    
    init(dictionary: [String:Any]) {
        self.fullName = dictionary["full_name"] as? String ?? "No Name"
        
        self.repositoryID = String(describing: dictionary["id"] ?? "No Repo ID")
        
        if let owner = dictionary["owner"] as? [String:Any] {
            let urlString = owner["html_url"] as? String ?? "No URL"
            if let unwrappedURL = URL(string: urlString) {
                self.htmlURL = unwrappedURL
            }
        }
    }
}

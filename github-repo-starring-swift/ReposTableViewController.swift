//
//  ReposTableViewController.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    var store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        store.getRepositories { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)
        cell.textLabel?.text = self.store.repositories[indexPath.row].fullName
//        if let url = self.store.repositories[indexPath.row].htmlURL {
//            cell.textLabel?.text = String(describing: url)
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = self.store.repositories[indexPath.row].fullName
        GithubAPIClient.checkIfRepositoryIsStarred(repo) { _ in
            GithubAPIClient.toggleStarStatus(for: repo, completion: { (value) in
                if value == "starred" {
                    let alert = UIAlertController(title: "Repo Starred", message: "You've Just Starred the Repo!", preferredStyle: .alert)
                    let continueAction = UIAlertAction(title: "OK", style: .cancel)
                    alert.addAction(continueAction)
                    self.present(alert, animated: true, completion: nil)
                } else if value == "unstarred" {
                    let alert = UIAlertController(title: "Repo Unstarred", message: "You've Just Unstarred the Repo!", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    let continueAction = UIAlertAction(title: "OK", style: .cancel)
                    alert.addAction(continueAction)
                }
            })
        }
    }
    
}

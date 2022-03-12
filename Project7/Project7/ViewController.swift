//
//  ViewController.swift
//  Project7
//
//  Created by Nathan Segura on 3/10/22.
//  Copyright © 2022 Nathan Segura. All rights reserved.
//

import UIKit

extension Array where Element: Equatable {
    func all(where predicate: (Element) -> Bool) -> [Element] {
        return self.compactMap { predicate($0) ? $0 : nil }
    }
}

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Petitions"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPetitions))
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    @objc func showCredits() {
        let alertController = UIAlertController(title: "Credits", message: "This data comes from the WeThePeople API of the whitehouse.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true)
    }
    
    @objc func searchPetitions() {
        let alertController = UIAlertController(title: "Search", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        alertController.textFields?[0].placeholder = "Search for a petition"
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { [weak self, weak alertController] _ in
            guard let self = self else { return }
            guard let filterKeyword = alertController?.textFields?[0].text else { return }
            
            if filterKeyword == "" {
                self.filteredPetitions = self.petitions
            } else {
                self.filteredPetitions.removeAll()
                
                for petition in self.petitions {
                    if petition.title.lowercased().contains(filterKeyword) {
                        self.filteredPetitions.append(petition)
                    }
                }
            }
            self.tableView.reloadData()
        }
        
        alertController.addAction(searchAction)
        present(alertController, animated: true)
    }
    
    func showError() {
        let alertController = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.detailItem = filteredPetitions[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}


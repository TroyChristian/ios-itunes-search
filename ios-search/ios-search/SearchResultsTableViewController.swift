//
//  SearchResultsTableViewController.swift
//  ios-search
//
//  Created by Lambda_School_Loaner_219 on 12/3/19.
//  Copyright © 2019 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let searchResultsController = SearchResultController()
    var resultType: ResultType!
     var searchTerm = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

    }
    
    @IBAction func searchResultChanged(_ sender: Any) {
        if searchResultsController.searchResults.count > 0 {
            searchResultsController.searchResults.removeAll()
            tableView.reloadData()
        }
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
    }
    
   /* {
        
        if searchResultsController.searchResults.count > 0 {
            searchResultsController.searchResults.removeAll()
            tableView.reloadData()
        }
        
        switch resultTypeSegmentedControll.selectedSegmentIndex {
               case 0:
                   resultType = .software
               case 1:
                   resultType = .musicTrack
               case 2:
                   resultType = .movie
               default:
                   break
               }
        startNewSearch(term: searchTerm, resultType: resultType)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    } */

    // MARK: - Table view data source
    
    private func startNewSearch(term: String, resultType: ResultType) {
        searchResultsController.preformSearch(searchTerm: term, resultType: resultType) { error in
                 if let error = error {
                     print("Error fetching results: \(error)")
                 }
                 DispatchQueue.main.async {
                 self.tableView.reloadData()
                 }
             }
          }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
         let result = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        


        return cell
    } }
    
    extension SearchResultsTableViewController: UISearchBarDelegate {
        func searchBarSearchButtonClicked( _ SearchBar: UISearchBar) {
            guard let term = searchBar.text, !term.isEmpty else {return}
             searchTerm = term
            startNewSearch(term:searchTerm, resultType: resultType)
        }
    }
    

  /* extension SearchResultsTableViewController: UISearchBarDelegate {
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          guard let term = searchBar.text, !term.isEmpty else { return }
          searchTerm = term
          startNewSearch(term: searchTerm, resultType: resultType)
      }
  }
*/


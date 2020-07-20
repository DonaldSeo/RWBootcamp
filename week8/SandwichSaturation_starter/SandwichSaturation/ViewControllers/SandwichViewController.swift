//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
  
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  let searchController = UISearchController(searchResultsController: nil)
  var allSandwiches = [Sandwich]()
  var fetchedRC = NSFetchedResultsController<Sandwich>()
  var filteredSandwiches = [Sandwich]()
  let defaults = UserDefaults.standard
  private var query = ""
  var refreshTableView: Bool = true

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    if hasLaunched() {
      loadSandwiches()
    } else {
      refresh()
    }
    refreshTableView = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
    navigationItem.rightBarButtonItem = addButton
    
    // Setup Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
    searchController.searchBar.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func loadSandwiches() {
    let _ = loadFromJSON()
  }
  
  
  private func refresh() {
    let request = Sandwich.fetchRequest() as NSFetchRequest<Sandwich>
    if !query.isEmpty {
      request.predicate = NSPredicate(format: "name CONTAINS[cd]", query)
    }

    let sort = NSSortDescriptor(key: #keyPath(Sandwich.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
    request.sortDescriptors = [sort]

    do {
      fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: #keyPath(Sandwich.name), cacheName: nil)
      try fetchedRC.performFetch()
      if let objs = fetchedRC.fetchedObjects {
        allSandwiches = objs
      }
    } catch let error as NSError {
        print("Could not fetch \(error), \(error.userInfo)")
    }
  }

  func loadFromJSON() -> [Sandwich] {
    guard let sandwichJSONURL = Bundle.main.url(forResource: "sandwiches", withExtension: "json") else {
      return []
    }
    let decoder = JSONDecoder()
    
    do {
      let sandwichData = try Data(contentsOf: sandwichJSONURL)
      let sandwiches: [SandwichData] = try decoder.decode([SandwichData].self, from: sandwichData)
      sandwiches.forEach { (sandwich) in
        saveSandwich(sandwich)
      }
      return allSandwiches
    } catch let error {
      print(error)
    }
    return []
  }
  
  func hasLaunched() -> Bool {
    
    if !defaults.bool(forKey: "FirstLaunch") {
      defaults.set(true, forKey: "FirstLaunch")
      return true
    }
    return false
  }

  func saveSandwich(_ sandwich: SandwichData) {
    
    let sandwichCD = Sandwich(context: context)
    let thisSauceAmount = SauceAmountModel(context: context)
    sandwichCD.name = sandwich.name
    sandwichCD.image = sandwich.imageName
    thisSauceAmount.sauceAmount = sandwich.sauceAmount
    sandwichCD.sauceAmount = thisSauceAmount
    allSandwiches.append(sandwichCD)
    appDelegate.saveContext()

    if !refreshTableView {
      tableView.reloadData()
    }
  }

  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  
  // MARK: - Search Controller
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(_ searchText: String, sauceAmount: SauceAmount? = nil) {
    let request = Sandwich.fetchRequest() as NSFetchRequest<Sandwich>
    let sandwichNamePredicate = NSPredicate(format: "name CONTAINS [cd]%@", searchController.searchBar.text!)
    let saucePredicate = NSPredicate(format: "sauceAmount.sauceAmountString = %@", sauceAmount!.rawValue)
    var predicate = NSCompoundPredicate()
    
    if sauceAmount == .any {
      predicate = NSCompoundPredicate(type: .and, subpredicates: [sandwichNamePredicate])
    } else {
      if !isSearchBarEmpty {
        predicate = NSCompoundPredicate(type: .and, subpredicates: [sandwichNamePredicate, saucePredicate])
      } else {
        predicate = NSCompoundPredicate(type: .and, subpredicates: [saucePredicate])
      }
    }
    
    request.predicate = predicate
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    request.sortDescriptors=[sortDescriptor]
    
    do {
      filteredSandwiches = try context.fetch(request)
    } catch let error as NSError {
      print("Error fetching data from context. \(error), \(error.userInfo)")
    }
    
    tableView.reloadData()
  }
  
  var isFiltering: Bool {
    searchController.searchBar.selectedScopeButtonIndex = defaults.integer(forKey: "selectedScope")
    let searchBarScopeIsFiltering =
      searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive &&
      (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredSandwiches.count : allSandwiches.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }
    
    let sandwich = isFiltering ? filteredSandwiches[indexPath.row] : allSandwiches[indexPath.row]
    cell.nameLabel.text = sandwich.name
    cell.sauceLabel.text = sandwich.sauceAmount.sauceAmountString!
    cell.thumbnail.image = UIImage(named: sandwich.image)

    return cell
  }
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])

    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![selectedScope])
    defaults.set(selectedScope, forKey: "selectedScope")
    print(defaults.integer(forKey: "selectedScope"))
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}





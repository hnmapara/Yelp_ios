//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate, UISearchBarDelegate {
    
    let segueIdFilter:String = "filter"
    let segueIdMap:String = "map"
    var businesses: [Business]!
    
    @IBOutlet weak var tableView: UITableView!

    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //--------------SEARCHBAR-----------------
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        //searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        //tableView.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        //----------------------------------------
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        searchWithTerm(searchTerm: "Restaurants")
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        }
        return 0
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        return cell
    }
    

// -----------------LIVE SEARCH AS USER TYPE------------------
//    public func updateSearchResults(for searchController: UISearchController) {
//        if let searchText = searchController.searchBar.text {
//            if searchText.characters.count > 3 {
//                //searchWithTerm(searchTerm: searchText)
//            }
//        }
//    }
    
    
    //---------------Search after search button is clicked---------------
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // called when keyboard search button pressed
        if let searchText = searchBar.text {
            if searchText.characters.count > 3 {
                searchWithTerm(searchTerm: searchText)
            }
        }
    }
    
    
    //---------------Cancel handling - falling back to "Restaurant search results---------------
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchWithTerm(searchTerm: "Restaurants")
    }
    
    func searchWithTerm(searchTerm: String) {
        Business.searchWithTerm(term: searchTerm, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let id : String! = segue.identifier
        
        if (id == segueIdMap) {
            let mapViewController = segue.destination as! MapViewController
            mapViewController.businesses = businesses

        } else {
        
            let navigationController = segue.destination as! UINavigationController
            let filtersViewController = navigationController.topViewController as! FiltersViewController
        
            filtersViewController.delegate = self
        }
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        let categories = filters["categories"]
        Business.searchWithTerm(term: "Restaurants", sort: nil, categories: categories as! [String]?, deals: nil) { (businesses: [Business]?, error : Error?) in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }
    
}

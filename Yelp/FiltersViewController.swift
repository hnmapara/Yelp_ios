//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Harshit Mapara on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var categories:[[String:String]]!
    var switchStates = [Int:Bool]()
    weak var delegate : FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = yelpCategories()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return filterDistance().count
        case 1:
            return filterSortBy().count
        case 2:
            return categories.count
        default:
            return 0
        }
        
    }
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        switch indexPath.section {
        case 0 :
            cell.switchLabel.text = filterDistance()[indexPath.row]
            break
        case 1:
            cell.switchLabel.text = filterSortBy()[indexPath.row]
            break
        case 2:
            cell.switchLabel.text = categories[indexPath.row]["name"]
            break
        default:
            break
        }
        
        cell.delegate = self
        
//        if (switchStates[indexPath?.row] != nil) {
//            cell.onSwitch.isOn = switchStates[indexPath?.row]
//        } else {
//            cell.onSwitch.isOn = false
//        }
        //Below line is shortcut
        
        cell.onSwitch.isOn = switchStates[indexPath.row] ?? false
        return cell
    }
    
    func swithcCell(switchCell: SwitchCell, didChangedValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)
        switchStates[(indexPath?.row)!] = value
        print("FiltersVC got switch event")
    }
    
    
    @available(iOS 2.0, *)
    public func numberOfSections(in tableView: UITableView) -> Int {
    // Default is 1 if not implemented
        return 3
    }
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {// fixed font style. use custom view (UILabel) if you want something different
        return filterSections()[section]
    }
    

    @IBAction func onCancelButton(_ sender: AnyObject) {
        dismiss(animated: true) { 
            
        }
    }
    
    
    @IBAction func onSearchButton(_ sender: AnyObject) {
        var filters = [String:AnyObject]()
        var selectedCategories = [String]()
        for (row, isSelected) in switchStates {
            if isSelected {
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories as AnyObject?
        }
        dismiss(animated: true) {
            self.delegate?.filtersViewController!(filtersViewController: self, didUpdateFilters: filters)
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func yelpCategories() -> [[String:String]] {
        return [
            ["name" : "Afghan", "code" : "afghani"],
            ["name" : "American, New", "code" : "newamerican"],
            ["name" : "Arabian", "code" : "arabian"],
            ["name" : "Arabian", "code" : "arabian"],
            ["name" : "Mexican", "code" : "mexican"],
            ["name" : "Indian", "code" : "indpak"],
            ["name" : "Japanese", "code" : "japanese"],
            ["name" : "Korean", "code" : "korean"],
            ["name" : "Halal", "code" : "halal"]
        ]
    }
    
    func filterSections() -> [String] {
        return [
                "Distance",
                "Sort By",
                "Category"
                ]
    }
    
    func filterDistance() -> [String] {
        return [
            "Auto",
            "0.3 mile",
            "1 mile"
        ]
    }
    
    func filterSortBy() -> [String] {
        return [
            "Best Match",
            "A->Z",
            "Z->A",
            "Prince low to high"
        ]
    }
    

}

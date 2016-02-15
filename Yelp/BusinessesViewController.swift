//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate {

    var businesses: [Business]!
    var filteredbusiness: [Business]!
    
    @IBOutlet weak var tableView: UITableView!
   
    var searchBar = UISearchBar()
    var isMoreDataLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Restaurants"
    
        searchBar.delegate = self
        
        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredbusiness = businesses;
            self.tableView.reloadData();
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredbusiness != nil{
            return filteredbusiness!.count
        }else{
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCellTableViewCell
        
        cell.business = filteredbusiness[indexPath.row]
        
        return cell
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false;
        searchBar.text = "";
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            filteredbusiness = businesses
        }else{
            filteredbusiness = businesses.filter({ (business: Business) -> Bool in
                
                if business.name!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil{
                        return true
                }else{
                    return false
                }
            })
        }
        tableView.reloadData()
    }
    
    func loadMoreData(){
        self.isMoreDataLoading = false
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(!isMoreDataLoading){
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffset = scrollViewContentHeight - tableView.bounds.size.height
            
            if(scrollView.contentSize.height > scrollOffset && tableView.dragging){
                isMoreDataLoading = true
                
                loadMoreData()
            }
            
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let business = businesses![indexPath!.row]
        
        let mapViewController = segue.destinationViewController as! MapViewController
        mapViewController.business = business
        
    }
    

}

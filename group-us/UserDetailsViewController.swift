//
//  UserDetailsViewController.swift
//  group-us
//
//  Created by SimpuMind on 3/10/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var names: [String]?
    
    var grouByArray:[[String]]?
    
    var pairBy: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Pair Details"
        
        if let pairBy = pairBy{
            grouByArray = names?.chunked(by: pairBy)
            if pairBy > 2{
                tableView.rowHeight = 260
            }else{
                tableView.rowHeight = 130
            }
        }else{
            grouByArray = names?.chunked(by: 2)
        }
    }

    
}

extension UserDetailsViewController: UITabBarDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grouByArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsCell", for: indexPath) as! DetailsCell
        
        cell.names = grouByArray?[indexPath.item]
        
        cell.groupCountLabel.text = "Group \(indexPath.item + 1)"
        
        return cell
    }
    
    
    
}

extension Array {
    func chunked(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0 ..< Swift.min($0 + chunkSize, self.count)])
        }
    }
}

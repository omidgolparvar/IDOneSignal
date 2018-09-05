//
//  TableViewController.swift
//  Example
//
//  Created by Omid Golparvar on 9/5/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
	
}

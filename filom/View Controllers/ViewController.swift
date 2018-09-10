//
//  ViewController.swift
//  filom
//
//  Created by Bastien Beurier on 6/25/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var numRows = 100

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: UITableView Data Source

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? numRows : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filom-cell")!
        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    
}

// MARK: Actions

extension ViewController {
    
    @IBAction func addButtonPressed(_ sender: Any) {
        numRows += 1
        let newIndexPath = IndexPath(row: numRows - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: UITableViewRowAnimation.automatic)
        tableView.scrollToRow(at: newIndexPath, at: UITableViewScrollPosition.bottom, animated: true)
    }
    
}


//
//  MasterViewController.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/26.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import UIKit

class TopMenuViewController: UITableViewController {

    var items = ["a", "b"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selected = tableView.indexPathForSelectedRow?.row ?? 0
        if segue.identifier == "showDetail" {
            guard let nav = segue.destination as? UINavigationController,
                  let vc = nav.topViewController as? TwoPlanesViewController else { return }
            
            vc.title = items[selected]
            vc.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            vc.navigationItem.leftItemsSupplementBackButton = true
            
            splitViewController?.toggleMasterView()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel!.text = items[indexPath.row].description
        return cell
    }
}

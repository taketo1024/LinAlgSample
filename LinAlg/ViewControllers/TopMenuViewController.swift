//
//  MasterViewController.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/26.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import UIKit

class TopMenuViewController: UITableViewController {
    
    enum Item: CaseIterable {
        case general, scale, invert, rotate, oproj
        var title: String {
            switch self {
            case .general: return "線形変換"
            case .scale  : return "拡大・縮小"
            case .invert : return "反転"
            case .rotate : return "回転"
            case .oproj  : return "正射影"
            }
        }
        var transform: Mat2 {
            switch self {
            case .general: return .identity
            case .scale  : return .diagonal(2, 3)
            case .invert  : return .diagonal(1, -1)
            case .rotate : return .rotation(0.5235)
            case .oproj  : return .unit(0, 0)
            }
        }
    }
    
    var items = Array(Item.allCases)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Menu"
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
            
            let item = items[selected]
            vc.title = item.title
            vc.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            vc.navigationItem.leftItemsSupplementBackButton = true
            vc.initialTransform = item.transform
            
            splitViewController?.toggleMasterView()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Item.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
}

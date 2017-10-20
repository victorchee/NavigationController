//
//  MasterViewController.swift
//  NavigationAppearance
//
//  Created by qihaijun on 12/2/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, NavigationControllerAppearanceContext {
    private let values: [Appearance] = (0 ..< 10).map { (_) -> Appearance in
        Appearance.random()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let target = segue.destination as? DetailViewController, let index = tableView.indexPath(for: cell)?.row {
            target.appearance = values[index]
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        
        let appearance = values[indexPath.row]
        cell.contentView.backgroundColor = appearance.navigationBar.backgroundColor
        cell.textLabel?.textColor = appearance.navigationBar.tintColor
        cell.textLabel?.text = "Sample #\(indexPath.row + 1)"
        cell.textLabel?.backgroundColor = UIColor.clear
        
        return cell
    }
    
    // MARK: - AppearanceNavigationControllerContext
    func preferredNavigationControllerAppearance(navigationController: UINavigationController) -> Appearance? {
        return Appearance.lightAppearance
    }
}

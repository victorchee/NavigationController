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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell, target = segue.destinationViewController as? DetailViewController, index = tableView.indexPathForCell(cell)?.row {
            target.appearance = values[index]
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let appearance = values[indexPath.row]
        cell.contentView.backgroundColor = appearance.navigationBar.backgroundColor
        cell.textLabel?.textColor = appearance.navigationBar.tintColor
        cell.textLabel?.text = "Sample #\(indexPath.row + 1)"
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    // MARK: - AppearanceNavigationControllerContext
    func preferredNavigationControllerAppearance(navigationController: UINavigationController) -> Appearance? {
        return Appearance.lightAppearance
    }
}

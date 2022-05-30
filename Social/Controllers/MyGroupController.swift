//
//  MyGroupController.swift
//  Social
//
//  Created by Сергей Кулагин on 25.06.2021.
//

import UIKit

class MyGroupController: UITableViewController {

    @IBOutlet var groupsTableView: UITableView!
    @IBOutlet weak var groupsSearchBar: UISearchBar!
    
    var myGroups = [Group]()
    var searchResultArray = [Group]()
    var searchFlag = false
    
    let reuseIdentifierUniversalTableCell = "reuseIdentifierUniversalTableCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsSearchBar.delegate = self
        searchResultArray = myGroups
        self.tableView.register(UINib(nibName: "UniversalTableCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableCell)
        NotificationCenter.default.addObserver(self, selector: #selector(addNewGroup(_:)), name: NSNotification.Name(rawValue: "sendGroup"), object: nil)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        groupsSearchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        groupsSearchBar.endEditing(true)
    }
    
    func isContainInArray(group: Group) -> Bool {
        if myGroups.contains(where: { itemGroup in itemGroup.title == group.title}) {
        return true
    }
    return false
    }
    
    @objc func addNewGroup(_ notification: Notification) {
        guard let newGroup = notification.object as? Group else {return}
        if isContainInArray(group: newGroup) {
            return
        }
        myGroups.append(newGroup)
        self.tableView.reloadData()
    }
    
    func myGroupsArray() -> [Group] {
        if searchFlag {
            return searchResultArray
        }
        return myGroups
    }
    
    func arraySymbol() -> [String] {
        var resultArray = [String]()
        for item in myGroupsArray() {
            let nameSymbol = String(item.title.prefix(1))
            if !resultArray.contains(nameSymbol) {
            resultArray.append(nameSymbol)
        }
    }
        return resultArray
    }
    
    func arrayBySymbol(symbol:String) -> [Group] {
        var resultArray = [Group]()
        for item in myGroupsArray() {
            let nameSymbol = String(item.title.prefix(1))
            if nameSymbol == symbol {
                resultArray.append(item)
            }
        }
        return resultArray
    }
}
    
    extension MyGroupController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                searchFlag = false
            }
            else {
                searchFlag = true
                searchResultArray = myGroups.filter({item in item.title.lowercased().contains(searchText.lowercased())
            })
        }
            tableView.reloadData()
        }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        myGroups.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .middle)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayBySymbol(symbol: arraySymbol()[section]).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableCell, for: indexPath) as? UniversalTableCell else {return UITableViewCell()}
        let arrayBySymbolItems = arrayBySymbol(symbol: arraySymbol()[indexPath.section])
        cell.configure(group: arrayBySymbolItems [indexPath.row])
        
        return cell
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return arraySymbol().count
    }
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String? {
            return arraySymbol()[section].uppercased()
    }
}

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

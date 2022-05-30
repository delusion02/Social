//
//  FriendsViewController.swift
//  Social
//
//  Created by Сергей Кулагин on 25.06.2021.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let reuseIdentifierUniversalTableCell = "reuseIdentifierUniversalTableCell"
    let segueToPhotoController = "fromFriendsToPhoto"
    
    var friendsArray = [Friends]()
    var searchResultArray = [Friends]()
    var searchFlag = false
    
    func configure(userArray: [Friends]) {
        self.friendsArray = userArray
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchResultArray = friendsArray
        self.tableview.register(UINib(nibName: "UniversalTableCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableCell)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func myFriendsArray() -> [Friends] {
        if searchFlag {
            return searchResultArray
        }
        return friendsArray
    }
    
    func arraySymbol() -> [String] {
        var resultArray = [String]()
        for item in myFriendsArray() {
            let nameSymbol = String(item.name.prefix(1))
            if !resultArray.contains(nameSymbol) {
                resultArray.append(nameSymbol)
            }
        }
    return resultArray
    
    }

    func arrayBySymbol(symbol:String) -> [Friends] {
        var resultArray = [Friends]()
        for item in myFriendsArray() {
            let nameSymbol = String(item.name.prefix(1))
            if nameSymbol == symbol {
                resultArray.append(item)
            }
        }
        return resultArray
    }
}
    
extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchFlag = false
        }
        else {
            searchFlag = true
            searchResultArray = friendsArray.filter({ item in
                item.name.lowercased().contains(searchText.lowercased())
            })
    }
        tableview.reloadData()
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arraySymbol().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayBySymbol(symbol: arraySymbol()[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableCell, for: indexPath) as? UniversalTableCell else {return UITableViewCell()}
//        cell.configure(title: friendsArray[indexPath.row].name, image: friendsArray[indexPath.row].avatar)
//        cell.configure(friends: searchResultArray[indexPath.row])
        let arrayBySymbolItems = arrayBySymbol(symbol: arraySymbol()[indexPath.section])
        cell .configure(friends: arrayBySymbolItems[indexPath.row])
        
        return cell
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToPhotoController,
            let dst = segue.destination as? PhotoController,
            let user = sender as? Friends {
            dst.photoArray = user.photoArray
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableview.cellForRow(at: indexPath) as? UniversalTableCell,
              let cellObject = cell.savedObject as? Friends
              else {return}
        performSegue(withIdentifier: segueToPhotoController, sender: cellObject)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String? {
        return arraySymbol()[section].uppercased()
        }
    }


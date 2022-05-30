//
//  NewsTableViewController.swift
//  Social
//
//  Created by Сергей Кулагин on 06.07.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {

    @IBOutlet var newsTableView: UITableView!
    
    let reuseIdentifierNewsCell = "reuseIdentifierNewsCell"
    
    var allNews = [News]()
    
    func setupNews(){
        let firstNews = News(name: "Kobe Bryant posted:", image: UIImage(named: "lj1")!, description: "Good game, Bro")
        allNews.append(firstNews)
        let secondNews = News(name: "LeBron James posted:", image: UIImage(named: "k1")!, description: "Thank U")
        allNews.append(secondNews)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNews()
        newsTableView.delegate = self
        newsTableView.dataSource = self
            newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierNewsCell)
                addToTapToHideKeyboard()
        }


    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countArray = allNews.count
        // #warning Incomplete implementation, return the number of rows
        return countArray
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierNewsCell , for: indexPath) as? NewsCell else {return UITableViewCell()}

        cell.configures(news: allNews[indexPath.row])

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
    extension UITableViewController {
        func addToTapToHideKeyboard() {
            let tap = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
            view.addGestureRecognizer(tap)
        
        }
    }

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


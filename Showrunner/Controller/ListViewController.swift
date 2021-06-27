//
//  ViewController.swift
//  Showrunner
//
//  Created by mac on 24/06/2021.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var segmentControlle: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var show = Shows()
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        show.urlString += searchText
        
        show.getData {
            DispatchQueue.main.async {
                self.sortTable()
            }
        }
        
    }

    func sortTable(){
        switch segmentControlle.selectedSegmentIndex {
        case 0:
            show.showsArray.sort(by: {
                $0.show.name < $1.show.name
            })
        case 1:
            show.showsArray.sort(by: {
                $0.show.rating?.average ?? 0.0 > $1.show.rating?.average ?? 0.0
            })
        default:
            print("Error!!!")
        }
        tableView.reloadData()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailVC
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        destination.modalPresentationStyle = .fullScreen
        destination.show = show.showsArray[selectedIndexPath.row].show
    
    }
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        sortTable()
    }
}
extension ListViewController:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return show.showsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = show.showsArray[indexPath.row].show.name
        if let rating = show.showsArray[indexPath.row].show.rating?.average{
            cell.detailTextLabel?.text = "\(rating)"
        }else{
            cell.detailTextLabel?.text = "-"
        }
        return cell
    }
}


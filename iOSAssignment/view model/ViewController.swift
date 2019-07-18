//
//  ViewController.swift
//  iOSAssignment
//
//  Created by Tu (Callie) T. NGUYEN on 7/17/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    let cellId = "UserCellId"
    private let refreshControl = UIRefreshControl()
    let segueProfileIdentifier = "goToUserDetailScreen"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "User List"
        setup()
        fetchData()
    }

    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        
        
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshData(_ sender: Any) {
        // Fetch Weather Data
        APIServices.shared.fetchData { (data) in
            guard let data = data else { return }
            self.users = data
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                // stop activityIndicatorView
            }
        }
        
    }

    
    func fetchData() {
        APIServices.shared.fetchData { (data) in
            guard let data = data else { return }
            
            self.users = data
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ProfileController {
            let vc = segue.destination as? ProfileController
            let index = sender as! Int
            
            vc?.user = self.users[index]
        }
    }

}


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        cell.setupViews(user: users[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueProfileIdentifier, sender: indexPath.row)
    }
    
}

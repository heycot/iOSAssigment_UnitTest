//
//  ProfileController.swift
//  iOSAssignment
//
//  Created by Tu (Callie) T. NGUYEN on 7/18/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var userAvatar: CustomUIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userInfor: UILabel!
    @IBOutlet weak var userAbout: UILabel!
    @IBOutlet weak var userRepo: UILabel!
    @IBOutlet weak var userFollowers: UILabel!
    @IBOutlet weak var userFollowings: UILabel!
    
    var user = User()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDetail()
        
    }
    
    func getUserDetail() {
        APIServices.shared.getDetailUser(id: user.id ?? 0) { (data) in
            guard let data = data else { return }
            
            self.user = data
            self.setupView()
        }
    }
    

    func setupView() {
        userAvatar.loadImageUsingUrlString(urlString: user.avatar_url ?? "")
        userName.text = user.login
        userInfor.text = user.events_url
        userAbout.text = user.gists_url
        userRepo.text = String(user.public_repos ?? 0)
        userFollowers.text = String(user.followers ?? 0)
        userFollowings.text = String(user.following ?? 0)
        
        self.reloadInputViews()
    }
    
    func loadStarByUrl() {
        
        userRepo.getDataWithUrl(url: user.repos_url ?? "", key: "repos_\(user.id ?? 0)")
        userFollowers.getDataWithUrl(url: user.followers_url ?? "", key: "followers_\(user.id ?? 0)")
        //        userFollowings.getDataWithUrl(url: user.following_url ?? "", key: "followings_\(user.id ?? 0)")
        userFollowings.getDataWithUrl(url:  "https://api.github.com/users/mojombo/following", key: "followings_\(user.id ?? 0)")
    }
    

}

extension UILabel {
    
    func getDataWithUrl(url: String, key: String) {
        APIServices.shared.countUser(url: url, key: key) { (data) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.text = String(data)
            }
        }
    }
}

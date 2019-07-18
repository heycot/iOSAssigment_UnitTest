//
//  UserCell.swift
//  iOSAssignment
//
//  Created by Tu (Callie) T. NGUYEN on 7/17/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var userAvatar: CustomUIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userInfor: UILabel!
    
    func setupViews(user: User) {
        userAvatar.loadImageUsingUrlString(urlString: user.avatar_url ?? "")
        userName.text = user.login
        userInfor.text = user.html_url
    }
    
}



let imageCache = NSCache<AnyObject, AnyObject>()

class CustomUIImageView : UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        image = nil
        
        if let imageFromCatche = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCatche
            self.setBorderRadious(color: .white)
            return
        } else {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    
                    if self.imageUrlString == urlString {
                        self.image = UIImage(data: data!)
                        self.setBorderRadious(color: .white)
                    }
                    
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    
                }
                }.resume()
        }
        
    }
    
    
    func setBorderRadious(color: UIColor) {
        self.layer.cornerRadius = (self.frame.size.width  / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color.cgColor
    }
    
}


//
//  APIServices.swift
//  iOSAssignment
//
//  Created by Tu (Callie) T. NGUYEN on 7/17/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import UIKit

let usersCache = NSCache<AnyObject, AnyObject>()

class APIServices {
    static let shared = APIServices()
    
    
    func fetchData(completion: @escaping ([User]?) -> Void ) {
        let url = NSURL(string: "https://api.github.com/users")
        let request = URLRequest(url: url! as URL )

        
        if let usersFromCatche = usersCache.object(forKey: "users" as AnyObject) as? [User] {
            completion(usersFromCatche)
        } else {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                
                do {
                    
                    let users = try JSONDecoder().decode([User].self, from: data!)
                    usersCache.setObject(users as AnyObject, forKey: "users" as AnyObject)
                    
                    DispatchQueue.main.async {
                        completion(users)
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
            }.resume()
        }
        
    }
    

    func getDetailUser(id: Int, completion: @escaping (User?) -> Void ) {
        let url = NSURL(string: "https://api.github.com/user/\(id)")
        let request = URLRequest(url: url! as URL )
        
        
        if let userFromCatche = usersCache.object(forKey: "user_\(id)" as AnyObject) as? User {
            completion(userFromCatche)
        } else {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                
                do {
                    
                    let user = try JSONDecoder().decode(User.self, from: data!)
                    usersCache.setObject(user as AnyObject, forKey: "user_\(id)" as AnyObject)
                    
                    DispatchQueue.main.async {
                        completion(user)
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
                }.resume()
        }
    }
    
    
    func countUser(url: String, key: String, completion: @escaping (Int?) -> Void) {
        let urlNS = NSURL(string: url)
        let request = URLRequest(url: urlNS! as URL )
        
        
        if let dataFromCached = usersCache.object(forKey: key as AnyObject) as? Int {
            completion(dataFromCached)
        } else {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                
                do {
                    
                    let users = try JSONDecoder().decode([User].self, from: data!)
                    usersCache.setObject(users.count as AnyObject, forKey: key as AnyObject)
                    
                    DispatchQueue.main.async {
                        completion(users.count)
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
                }.resume()
        }
    }
}

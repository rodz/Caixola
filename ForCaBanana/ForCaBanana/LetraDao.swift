//
//  LetraDao.swift
//  ForCaBanana
//
//  Created by student on 02/05/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

class Letra {
    var letra: String
    
    init(json: [String: String]) {
        self.letra = json["payload"] ?? ""
    }
}

class LetraDAO {
    
    static func getLetra (callback: @escaping ((Letra) -> Void)) {
        
        let endpoint: String = "https://plantaiot14.mybluemix.net/getLetra"
        
        guard let url = URL(string: endpoint) else {
            print("Erroooo: Cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("Error = \(String(describing: error))")
                return
            }
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            print("responseString = \(String(describing: responseString))")
            
            DispatchQueue.main.async() {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                        
                        let letra = Letra(json: json.last as! [String : String])
                        
                        print("\(letra.letra) foi a letra colocada")
                        
                        callback(letra)
                        
                    }else {
                        print("JSON ERRADO")
                    }
                } catch let error as NSError {
                    print("Error = \(error.localizedDescription)")
                }
            }
            
        })
        
        task.resume()
    }
}

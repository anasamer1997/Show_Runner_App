//
//  Shows.swift
//  Showrunner
//
//  Created by mac on 24/06/2021.
//

import Foundation
import Alamofire

class Shows{
    struct Returned:Codable{
      //  var score:Double
        var show:Show
    }
    
    //MARK:- variables
    var urlString = "http://api.tvmaze.com/search/shows?q="
    var showsArray:[Returned] = []
    
    //MARK:- functions
    func getData(completed:@escaping() -> ()){
        guard let url = URL(string: urlString)  else {
            print("error")
            completed()
            return
        }
        
        // create URL request
        AF.request(url).responseJSON{ (dataResponse) in
            if let error = dataResponse.error{
                print("error :\(error)")
            }
                do{
                    self.showsArray = try JSONDecoder().decode([Returned].self, from: dataResponse.data!)
                    print("returned :\(self.showsArray)")
                }catch{
                    print("JSON Error:\(error.localizedDescription)")
                }
            completed()
            }
        

    }
}

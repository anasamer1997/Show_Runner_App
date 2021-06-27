//
//  DetailVC.swift
//  Showrunner
//
//  Created by mac on 25/06/2021.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var ratinglbl: UILabel!
    @IBOutlet weak var networklbl: UILabel!
    @IBOutlet weak var languagelbl: UILabel!
    @IBOutlet weak var genreslbl: UILabel!
    @IBOutlet weak var imglbl: UIImageView!
    @IBOutlet weak var descriptionView: UITextView!
    
    
    var show:Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard show != nil else {
            print("no data")
            return
        }
        updateView()
    }
    
    func updateView(){
        var genresList = ""
        
        namelbl.text = show.name
        languagelbl.text = show.language ?? ""
        if let rating = show.rating?.average{
            ratinglbl.text = "\(rating)"
        }else{
            ratinglbl.text = "-"
        }
        //MARK:- converte the html scription to string
        show.summary = show.summary?.replacingOccurrences(of: "<[^>]+>", with: "",options: .regularExpression,range: nil)
        descriptionView.text = show.summary ?? ""
        networklbl.text = show.network?.name ?? ""
        if show.genres != nil{
            for genre in show.genres!{
                  genresList += "\(genre)\n"
            }
            if genresList != ""{
                genresList.removeLast()
            }
        }
        genreslbl.text = genresList
        //MARK:- download image data from url
        guard let url = URL(string: show.image?.original ?? "")else{return}
        do {
            let data = try Data(contentsOf: url)
            imglbl.image = UIImage(data: data)
        } catch  {
            print("Error:couldn't load image \(url)")
        }
    }
    
}

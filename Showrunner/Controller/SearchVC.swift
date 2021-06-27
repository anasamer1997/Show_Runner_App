//
//  SearchVC.swift
//  Showrunner
//
//  Created by mac on 27/06/2021.
//

import UIKit
import AVFoundation

class SearchVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var searchlbl: UILabel!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchBTN: UIButton!
    
    var audioPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
       
        imgView.alpha = 0.0
        searchlbl.alpha = 0.0
        searchTF.alpha = 0.0
        searchBTN.alpha = 0.0
        playSound(name: "tvStartUp")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 5.0) {
            self.imgView.alpha = 1.0
        }
        
        UIView.animate(withDuration: 1.0, delay: 4.0, animations: {
            self.searchlbl.alpha = 1.0
            self.searchTF.alpha = 1.0
            self.searchBTN.alpha = 1.0
        })
    }
    
    func playSound(name:String){
        if let sound = NSDataAsset(name: name ){
            do {
                audioPlayer = try AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }else{
            print("Error: couldn't read audio data from file :\(name)")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var searchText = searchTF.text!
        searchText = searchText.replacingOccurrences(of: " ", with: "%20")
        let destination = segue.destination as! ListViewController
        destination.searchText = searchText
        
    }

}

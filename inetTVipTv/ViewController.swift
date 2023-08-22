//
//  ViewController.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 21.6.2023.
//

import UIKit
import AVFoundation
import AVKit

@IBDesignable

class ViewController: UIViewController {

    @IBOutlet weak var TVBUTTON: UIBarButtonItem!
    @IBOutlet weak var Input: UITextField!
    @IBOutlet weak var StacviewUp: UIStackView!
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var ButtonFirst: UIButton!
    let player = Player()
    let fileHandler = MtriUfileHandle()

    @IBOutlet weak var testButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        if( fileHandler.ReadFileFromMemory())
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

        
    
    @IBAction func FirstChanelButton(_ sender: Any) {
        
        
        if(Input.text!.count >= 20)
        {
            fileHandler.deleteFileFromMemory()
            fileHandler.DownlondFromUrl(myFileURL: Input.text!)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func testButtonFuncktion(_ sender: Any) {

        
        let adress = "http://213.226.69.162/iptv/UV8MN3KV3YZ6KW/12191/1692558480000.ts?md5=agbLlekFImk613byHIEmWw"
        
        let videoURL = URL(string: adress)
        
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            print(AVPlayer.Status.failed)
                playerViewController.player!.play()
            
            }
    }
    
 
}


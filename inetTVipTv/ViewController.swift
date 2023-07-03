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

    @IBOutlet weak var StacviewUp: UIStackView!
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var russia1Button: UIButton!
    @IBOutlet weak var NtvButton: UIButton!
    @IBOutlet weak var ButtonFirst: UIButton!
    let player = Player()
    let fileHandler = MtriUfileHandle()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func PlayButton(_ sender: Any)
    {
        
//        player.playback()
        let videoURL = URL(string: "http://qrjvck10.socminlt.com/iptv/UV8MN3KV3YZ6KW/205/index.m3u8")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
 
    }
        
    
    @IBAction func FirstChanelButton(_ sender: Any) {
        
        let videoURL = URL(string: "http://qrjvck10.socminlt.com/iptv/UV8MN3KV3YZ6KW/204/index.m3u8")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    
    
    @IBAction func ntvButton(_ sender: Any) {
//        StackView.addArrangedSubview(Firs)
        let videoURL = URL(string: "http://qrjvck10.socminlt.com/iptv/UV8MN3KV3YZ6KW/213/index.m3u8")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }

    
    
 
}


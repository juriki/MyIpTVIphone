//
//  Player.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 25.6.2023.
//
import UIKit
import AVFoundation
import AVKit


class Player : UIViewController{
    
    
    func playback ()
    {
        let videoURL = URL(string: "http://qrjvck10.socminlt.com/iptv/UV8MN3KV3YZ6KW/205/index.m3u8")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
}

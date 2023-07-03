//
//  CollectionViewControllerChanels.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 1.7.2023.
//

import UIKit
import AVFoundation
import AVKit

//private let reuseIdentifier = "Cell"

class CollectionViewControllerChanels: UICollectionViewController {
    
    var chanelList: [String: String] = [:]
    var test: [String] = ["TESt", "EST"]
    var myChanelCategory: String = ""
    let fileHandler = MtriUfileHandle()
    
    
    
    override func viewDidLoad() {
        fileHandler.getChanel(getByCategory: myChanelCategory)
        chanelList = fileHandler.ChanelSelctedDict

        super.viewDidLoad()

    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chanelList.count
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let ChanelCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as? CollectionViewCellChanel
        {
            let key = Array(chanelList.keys)[indexPath.row]
            let array = chanelList[key] ??  ""
            ChanelCell.configureChanel(with: key)
            
            cell = ChanelCell
        }
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        fileHandler.getChanel(getByCategory: (chanelList.keys)[indexPath.row])
        let key = Array(chanelList.keys)[indexPath.row]
        let array = chanelList[key] ??  ""
        let videoURL = URL(string: array)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }

    }
}

//
//  CollectionViewControllerChanels.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 1.7.2023.
//

import UIKit
import AVFoundation
import AVKit


private let reuseIdentifier = "Cell"

class CollectionViewControllerChanels: UICollectionViewController {
    
    var chanelList: [String: String] = [:]
    var test: [String] = ["TESt", "EST"]
    var myChanelCategory: String = ""
    let fileHandler = MtriUfileHandle()
    var chanelNumber = 1
    var sortedDict: [String: String] = [:]
    var sorted: [(key: String, value: String)] = []
    let favoriteFile = FavoriteList()

    
    override func viewDidLoad() {
        if(myChanelCategory == "Favorite")
        {
            sorted = IsFavorite()
        }else{
            fileHandler.getChanel(getByCategory: myChanelCategory)
            chanelList = fileHandler.ChanelSelctedDict
            sortChanels(dict: chanelList)
        }

        navigationItem.title = myChanelCategory.capitalized
        super.viewDidLoad()

    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sorted.count
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        if let ChanelCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as? CollectionViewCellChanel
        {

            let key = Array(sorted)[indexPath.row]

            for (keys, value) in sorted {
                if keys == key.key
                {
                    break
                }
                chanelNumber += 1
            }

            _ = URL(string: key.value)
            ChanelCell.configureChanel(with: key.key, value: key.value, isFavorite: favoriteFile.checkToMoch(chanelNameTocheck: key.key), chanelCounter: chanelNumber  )
   
            chanelNumber += 1
            cell = ChanelCell
        }
        
        chanelNumber = 1 
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let key = Array(sorted)[indexPath.row]
        let videoURL = URL(string: key.value)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
    }
    
    

    
    
    
    func sortChanels(dict: Dictionary<String, String>)
    {
        let arr = dict.sorted(by: <)
        sorted = arr
    }

    func IsFavorite()  -> Array<(String, String)>
    {
        var channelsChekTo: Array<(String,String,String)> = Array()
        var funcChanelList: [(key: String, value: String)] = []
        channelsChekTo = favoriteFile.ReadFileToFavorite()
        channelsChekTo.forEach { (chanel, urli, favorite) in
            funcChanelList.append((key: chanel, value: urli))
        }
        funcChanelList.sort(by: <)
        return funcChanelList
    }

}



























//    func getThumbnailFromImage(url: URL, complition: @escaping ((_ image: UIImage)-> Void)){
//        DispatchQueue.global().async {
//            let asset = AVAsset(url: url)
//            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
//            avAssetImageGenerator.appliesPreferredTrackTransform = true
//
//            let thumbnailTime = CMTimeMake(value: 7, timescale: 1)
//            do
//            {
//                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumbnailTime, actualTime: nil)
//                let thumbImage = UIImage(cgImage: cgThumbImage)
//                DispatchQueue.main.async {
//                    complition(thumbImage)
//                }
//            }catch{
//                print(error.localizedDescription)
//            }
//        }
//    }

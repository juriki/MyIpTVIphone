//
//  CollectionViewCellChanel.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 1.7.2023.
//

import UIKit



class CollectionViewCellChanel: UICollectionViewCell {
    
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var PlayChannel: UILabel!
    @IBOutlet weak var LikeButton: UIButton!
    @IBOutlet weak var chanelCount: UILabel!
    let fileHandler = MtriUfileHandle()
    let favoritList = FavoriteList()
    let collectionView = CollectionViewController()
    var ChanelUrl = ""
    var like: Bool = false
    var channelsTocheck: Array<(String,String,String)> = Array()
    var channelsToDelte: Array<(String,String,String)> = Array()
    var myChanellNow = ""
    var chanelcount = 0
    
    
    func configureChanel(with chanelName: String, value: String, isFavorite: Bool = false, chanelCounter: Int, last: String)
    {
     
        channelsTocheck = favoritList.ReadFileToFavorite()
        chanelCount!.text = String(chanelCounter)
        like = isFavorite
        myChanellNow = chanelName
        if isFavorite{
            LikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else
        {
            LikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        if chanelName == last {
            cell.backgroundColor = .systemCyan
        }else{
            cell.backgroundColor = .systemBackground
        }
            ChanelUrl = value
            PlayChannel.text = chanelName
        }
        

    

    @IBAction func ButtonClicked(_ sender: Any) {
        
        if(like == false){
            favoritList.appendToFile(channel: PlayChannel.text!, chanelUrl: ChanelUrl)
            LikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            like = true
        }else{
            channelsToDelte = favoritList.ReadFileToFavorite()
            LikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoritList.deleteFileFromMemory()
            favoritList.CreateNewFile()
            channelsToDelte.forEach { (Chanel, urli, bool) in
                if Chanel != myChanellNow{
                    favoritList.appendToFile(channel: Chanel, chanelUrl: urli)
                }
            }
            like = false
        }

    }
}


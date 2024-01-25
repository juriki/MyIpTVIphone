//
//  CollectionViewCell.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 29.6.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var LockButton: UIButton!
    @IBOutlet private weak var ChanelName: UILabel!
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var ChanelsCount: UILabel!
    var fileHandler = MtriUfileHandle()
    let favoritList = FavoriteList()
    var isPotected = false
    var channelsFavorite: Array<(String,String,String)> = Array()
    
    func configure(with chanelName: String)
    {

        if isPotected
        {
            LockButton.setImage(UIImage(systemName: "lock.fill"), for: .normal)
        }else
        {
            LockButton.setImage(UIImage(systemName: "lock.open.fill"), for: .normal)
            
        }
        if chanelName == "Favorite"
        {
            channelsFavorite = favoritList.ReadFileToFavorite()
            ChanelsCount.text = "\(String(channelsFavorite.count)) : CH"
        }else if chanelName == "All Chanells"{
            
            ChanelsCount.text = "\(String(fileHandler.getAllChanells())) : CH"
        }
        else
        {
            ChanelsCount.text = "\(String(fileHandler.getChanel(getByCategory: chanelName))) : CH"
        }

        ChanelName.text = chanelName
    }
    
    func getCellStatus(with chanelName: String) -> Bool
    {
        print(String(isPotected) + " \t CellCategory isProtected")
        return isPotected
    }
    
    @IBAction func closeAccesToGroup(_ sender: Any) {
        isPotected.toggle()
        let image = isPotected ? "lock.fill" : "lock.open.fill"
        LockButton.setImage(UIImage(systemName: image), for: .normal)
    }
    
 
   
}

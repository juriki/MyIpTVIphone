//
//  CollectionViewCell.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 29.6.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var ChanelName: UILabel!
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var ChanelsCount: UILabel!
    var fileHandler = MtriUfileHandle()
    let favoritList = FavoriteList()
    var channelsFavorite: Array<(String,String,String)> = Array()
    
    func configure(with chanelName: String)
    {

        
        if chanelName == "Favorite"
        {
            channelsFavorite = favoritList.ReadFileToFavorite()
            ChanelsCount.text = "\(String(channelsFavorite.count)) : Channels"
        }else
        {
            ChanelsCount.text = "\(String(fileHandler.getChanel(getByCategory: chanelName))) : Channels"
        }
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 4.5
        cell.layer.borderWidth = 1.5
        ChanelName.text = chanelName
    }
}

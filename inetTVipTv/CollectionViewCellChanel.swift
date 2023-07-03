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
    func configureChanel(with chanelName: String)
    {
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 4.5
        cell.layer.borderWidth = 0.2

        PlayChannel.text = chanelName
        
    }
}


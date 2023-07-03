//
//  CollectionViewCell.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 29.6.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var ChanelName: UILabel!
    
    func configure(with chanelName: String)
    {
        ChanelName.text = chanelName
    }
}

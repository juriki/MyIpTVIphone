//
//  CollectionViewController.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 29.6.2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    var dataToDeleteAfgerTest: [String] = []
    var chanelDelagator = ""
    let fileHandler = MtriUfileHandle()
    let favoriteFile = FavoriteList()
    var channelsTocheck: Array<(String,String,String)> = Array()
    let favoritList = FavoriteList()


    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        fileHandler.ReadFileFromMemory()
        channelsTocheck = favoritList.ReadFileToFavorite()
        dataToDeleteAfgerTest = fileHandler.Cateroies
        super.viewDidLoad()
    }


    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataToDeleteAfgerTest.count
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let ChanelCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell
        {
            ChanelCell.configure(with: dataToDeleteAfgerTest[indexPath.row])
            cell = ChanelCell
        }
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(dataToDeleteAfgerTest[indexPath.row])
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CollectionViewControllerChanels") as! CollectionViewControllerChanels
        vc.myChanelCategory = dataToDeleteAfgerTest[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


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

class CollectionViewControllerChanels: UICollectionViewController, UISearchResultsUpdating, AVPlayerViewControllerDelegate {
    
    var chanelList: [String: String] = [:]
    var test: [String] = ["TESt", "EST"]
    var myChanelCategory: String = ""
    let fileHandler = MtriUfileHandle()
    var chanelNumber = 1
    var sortedDict: [String: String] = [:]
    var sorted: [(key: String, value: String)] = []
    var originalList: [(key: String, value: String)] = []
    let favoriteFile = FavoriteList()
    var searshCheck = false
    var playerViewController: AVPlayerViewController?
    var isTextVisible = true
    let videoPlayerManager = VideoPlayerManager()
    var lastChannel = ""
    
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = .link
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Поиск Канала"
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        playerViewController?.delegate = self


        if(myChanelCategory == "Favorite")
        {
            sorted = IsFavorite()
        }else{
            let empty = fileHandler.getChanel(getByCategory: myChanelCategory)
            if empty == 0{
                fileHandler.getChannelByNameOfCategory(categoryName: myChanelCategory)
            }
            chanelList = fileHandler.ChanelSelctedDict
            sortChanels(dict: chanelList)
        }
        if(myChanelCategory == "All Chanells"){
            fileHandler.getAllChanells()
            chanelList = fileHandler.ChanelSelctedDict
            sortChanels(dict: chanelList)
        }
        
        navigationItem.title = myChanelCategory.capitalized
        originalList = sorted
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
            
            for (keys, _) in sorted {
                if keys == key.key
                {
                    break
                }
                chanelNumber += 1
            }
            _ = URL(string: key.value)
            ChanelCell.configureChanel(with: key.key, value: key.value, isFavorite: favoriteFile.checkToMoch(chanelNameTocheck: key.key), chanelCounter: chanelNumber, last: lastChannel)
            chanelNumber += 1
            cell = ChanelCell
        }
        
        chanelNumber = 1
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let key = Array(sorted)[indexPath.row]
        let videoURL = URL(string: key.value)
        collectionView.reloadData()
        playVideo(videoURL: videoURL!, text: key.key)
    }
    
    
    func sortChanels(dict: Dictionary<String, String>){
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
    
    func playVideo(videoURL: URL, text: String){
        videoPlayerManager.chanelList = sorted
        lastChannel = videoPlayerManager.playVideo(videoURL: videoURL, text: text, in: self)
        
    }
    
    
    @objc(updateSearchResultsForSearchController:) func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text?.lowercased()
        
        if searchString!.count >= 1{
            sorted.removeAll()
            originalList.forEach { (chanelName, chanelUrl) in
                if chanelName.prefix(searchString!.count).lowercased() == searchString || chanelName.lowercased().contains(searchString!)
                {
                    sorted.append((key: chanelName, value: chanelUrl))
                }
            }
            collectionView.reloadData()
        }else
        {
            sorted = originalList
            collectionView.reloadData()
        }
    }
}











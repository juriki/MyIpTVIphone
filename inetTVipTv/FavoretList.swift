//
//  FavoretList.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 1.8.2023.
//

import UIKit
import AVFoundation

class FavoriteList : UIViewController{
    
    let FaoriteFilename = "FavoriteFile.txt"
    let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
    var FavoritChanelReturn: Array<String> = Array()

    let fileHandler = MtriUfileHandle()
    var channels: Array<(String,String,String)> = Array()
    
//   вызываем на  кнопке лике добовляем данные в channels
//    затем из пременной добовляем в 

    
    
    func FavoriteChanelFile(channel: String, chanelUrl:String )
    {
        let destinationFileUrl = documentsUrl.appendingPathComponent(FaoriteFilename)
        var chanelName = ""
        if channel != "Error"
        {
            chanelName = "Channel \(channel)\n\(chanelUrl)\nFavorite true"
        }
       
        do {
            print("Craeting  file")
            try chanelName.write(to: destinationFileUrl, atomically: false, encoding: String.Encoding.utf8)
            
        }
        catch {
            print("Error crating File")
        }

    }
    
    func CreateNewFile() {
        let destinationFileUrl = documentsUrl.appendingPathComponent(FaoriteFilename)
        let emptyTextToFile = ""
        do {
            print("Craeting New file")
            try emptyTextToFile.write(to: destinationFileUrl, atomically: false, encoding: String.Encoding.utf8)
            
        }
        catch {
            print("Error New crating File")
        }

    }
    
    func checkToMoch(chanelNameTocheck: String) -> Bool
    {
        var back = false
        var channelsChekTo: Array<(String,String,String)> = Array()
        channelsChekTo = ReadFileToFavorite()
        channelsChekTo.forEach { (Chanel, Urli, Favorite) in
            if(chanelNameTocheck == Chanel)
            {
                back = true

            }
        }
        return back
    }

    

    
    func appendToFile(channel: String, chanelUrl: String)
    {
        let destinationFileUrl = documentsUrl.appendingPathComponent(FaoriteFilename)
        let lineToaapend = "\nChannel \(channel)\n\(chanelUrl)\nFavorite true"
        if let fileUpdater = try? FileHandle(forUpdating: destinationFileUrl) {

            // Function which when called will cause all updates to start from end of the file
            fileUpdater.seekToEndOfFile()

            // Which lets the caller move editing to any position within the file by supplying an offset
            fileUpdater.write(lineToaapend.data(using: .utf8)!)

            // Once we convert our new content to data and write it, we close the file and that’s it!
            fileUpdater.closeFile()
        }
    }
    
    
    func ReadFileToFavorite()  -> Array<(String, String, String)>
    {
        var channelsToAdd: Array<(String,String,String)> = Array()
        let destinationFileUrl = documentsUrl.appendingPathComponent(FaoriteFilename)
        _ =  FileManager.default.contents(atPath: String(destinationFileUrl.path))
        var chanel = ""
        var urli = ""
        var favorit = ""
        do {
            let myFile2 = try String(contentsOf: destinationFileUrl, encoding: .utf8)
            var newtext = myFile2.components(separatedBy: "\n")
            for i in newtext.indices
            {

                if (newtext[i].hasPrefix("Channel ")){
                    
                    newtext[i].removeFirst(8)
                    chanel = newtext[i]
                }else if(newtext[i].hasPrefix("Favorite ")){
                    
                        newtext[i].removeFirst(9)
                        FavoritChanelReturn.append(newtext[i])
                        favorit = newtext[i]
                        
                    channelsToAdd.append((chanel,urli,favorit))
                    
                    }else{
                    urli = newtext[i]
                }
            }
        }catch
        {
            print("Error File read ReadFileToFavorite()")
            FavoriteChanelFile(channel: "Error", chanelUrl:"Error" )
            return channelsToAdd

        }
        
        return channelsToAdd
    }
    
    
    
    
    
    
    func deleteFileFromMemory()
    {
        let destinationFileUrl = documentsUrl.appendingPathComponent(FaoriteFilename)
        do {
            try FileManager.default.removeItem(at: destinationFileUrl)
            print("Successfully deleted file!")
        } catch {
            print("Error deleting file: \(error)")
        }
    }
}

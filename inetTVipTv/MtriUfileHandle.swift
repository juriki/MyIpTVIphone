//
//  MtriUfileHandle.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 27.6.2023.
//

import UIKit
import AVFoundation


class MtriUfileHandle : UIViewController{
    
    let fileName = "downloadedFile.txt"
    let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
    var ChanelDict: [String: String] = [:]
    var Cateroies: [String] = ["Favorite"]
    var ChanelSelctedDict: [String: String] = [:]
    
    
    
    
    func ReadFileFromMemory(){
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        _ =  FileManager.default.contents(atPath: String(destinationFileUrl.path))
        do {
            let text2 = try String(contentsOf: destinationFileUrl, encoding: .utf8)
            if text2.contains("#EXTGRP"){
                let newtext = text2.components(separatedBy: "#")
                for i in newtext.indices {
                    if (newtext[i].hasSuffix("m3u8\r\n")){
                        var notUrl = false
                        var ChaneCategory = newtext[i]
                        ChaneCategory.removeFirst(7)
                        guard let removeHttp = ChaneCategory.firstIndex(of: "h") else { return}
                        var category = ChaneCategory[..<removeHttp]
                        category.removeLast(1)
                        var ChanelName = newtext[i-1]
                        var ChanelUrl = newtext[i]
                        ChanelUrl.removeFirst(10)
                        ChanelUrl.removeLast(1)
                        ChanelName.removeFirst(19)
                        ChanelName.removeLast(1)
                        let vowels: Set<Character> = ["\"", "\r", ","]
                        ChanelName.removeAll(where: { vowels.contains($0) })
                        for i in Cateroies.indices{
                            var match = false
                            if(Cateroies[i] == String(category)){
                                match = true
                            }
                            if(Cateroies.count == i+1 && match == false ){
                                Cateroies.append(String(category))
                            }
                        }
                        while(notUrl == false){
                            if(ChanelUrl.prefix(4) != "http"){
                                ChanelUrl.removeFirst(1)}else
                            {
                                    notUrl = true
                                }
                        }
                        ChanelDict.updateValue(ChanelUrl, forKey: category + " || " + ChanelName)
                    }
                }
            }else
            {
                notVipDriveList()
            }
        }
        catch {
            print("Error of converitng file")
        }
        Cateroies.append("All Chanells")
    }
    
    
    func chekIfFileInMemory() -> Bool{
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        _ =  FileManager.default.contents(atPath: String(destinationFileUrl.path))
        do {
            _ = try String(contentsOf: destinationFileUrl, encoding: .utf8)
            return true
        } catch (let writeError) {
            print("read  File \(destinationFileUrl) : \(writeError)")
            return false
        }
    }
    
    func DownlondFromUrl(myFileURL: String){
        // Create destination URL
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        //Create URL to the source file you want to download
        let fileURL = URL(string: myFileURL)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@");
            }
        }
        task.resume()
    }
    
    func getAllChanells() -> Int{
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        _ =  FileManager.default.contents(atPath: String(destinationFileUrl.path))
        do
        {
            let text = try String(contentsOf: destinationFileUrl, encoding: .utf8)
            let newtext = text.components(separatedBy: "#")
            for i in newtext.indices {
                if (newtext[i].hasSuffix("m3u8\r\n"))
                {
                    var notUrl = false
                    var ChaneCategory = newtext[i]
                    ChaneCategory.removeFirst(7)
                    guard let removeHttp = ChaneCategory.firstIndex(of: "h") else { return 0 }
                    var category = ChaneCategory[..<removeHttp]
                    category.removeLast(1)
                        var ChanelName = newtext[i-1]
                        var ChanelUrl = newtext[i]
                        ChanelUrl.removeFirst(10)
                        ChanelUrl.removeLast(1)
                        ChanelName.removeFirst(19)
                        ChanelName.removeLast(1)
                        let vowels: Set<Character> = ["\"", "\r", ","]
                        ChanelName.removeAll(where: { vowels.contains($0) })
                        
                        while(notUrl == false){
                            if(ChanelUrl.prefix(4) != "http")
                            {
                                ChanelUrl.removeFirst(1)
                                
                            }else
                            {
                                notUrl = true
                            }
                        }
                        ChanelSelctedDict[ChanelName] = ChanelUrl
                    
                }
            }
            
        }catch
        {
            print("Cannot read File")
            return 0
        }
        return ChanelSelctedDict.count
    }
    
    func getChanel(getByCategory: String) -> Int
    {
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        _ =  FileManager.default.contents(atPath: String(destinationFileUrl.path))
        do
        {
            let text = try String(contentsOf: destinationFileUrl, encoding: .utf8)
            let newtext = text.components(separatedBy: "#")
            for i in newtext.indices {
                if (newtext[i].hasSuffix("m3u8\r\n"))
                {
                    var notUrl = false
                    var ChaneCategory = newtext[i]
                    ChaneCategory.removeFirst(7)
                    guard let removeHttp = ChaneCategory.firstIndex(of: "h") else { return 0 }
                    var category = ChaneCategory[..<removeHttp]
                    category.removeLast(1)
                    if(category == getByCategory )
                    {
                        var ChanelName = newtext[i-1]
                        var ChanelUrl = newtext[i]
                        ChanelUrl.removeFirst(10)
                        ChanelUrl.removeLast(1)
                        ChanelName.removeFirst(19)
                        ChanelName.removeLast(1)
                        let vowels: Set<Character> = ["\"", "\r", ","]
                        ChanelName.removeAll(where: { vowels.contains($0) })
                        
                        while(notUrl == false){
                            if(ChanelUrl.prefix(4) != "http")
                            {
                                ChanelUrl.removeFirst(1)
                                
                            }else
                            {
                                notUrl = true
                            }
                        }
                        ChanelSelctedDict[ChanelName] = ChanelUrl
                    }
                }
            }
            
        }catch
        {
            print("Cannot read File")
            return 0
        }
        return ChanelSelctedDict.count
    }
    
    
    func deleteFileFromMemory(){
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: destinationFileUrl)
            print("Successfully deleted file!")
        } catch {
            print("Error deleting file: \(error)")
        }
    }
    
    
    
    func notVipDriveList(){
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        _ =  FileManager.default.contents(atPath: String(destinationFileUrl.path))
        do {
            let SoureseFileText = try String(contentsOf: destinationFileUrl, encoding: .utf8)
            let NewString = SoureseFileText.components(separatedBy: "#")
            for i in NewString.indices{
                if i <= 1{
                    continue
                }
                let NewCategory = NewString[i].components(separatedBy: " ")
                let myCat = getCategory(findInString: NewCategory )
                    for i in Cateroies.indices{
                        let match = false
                        if Cateroies[i] == myCat{
                            break
                        }
                        if(Cateroies.count == i+1 && match == false ){
                            Cateroies.append(String(myCat))
                            break
                        }
                    }
                }
            }catch
            {
                print("Errorlet converitng file")
            }
    }
    
private func getCategory(findInString: Array<String>) -> String{
        var chanelname = ""
        for j in findInString.indices{
            if findInString[j].contains("group-title"){
                let category = findInString[j].components(separatedBy: ",")
                var myCat = String(category[0])
                let vowels: Set<Character> = ["\""]
                myCat.removeFirst(13)
                myCat.removeAll(where: { vowels.contains($0) })
//                поиск канала
                chanelname = String(findInString[j-2])
                chanelname.removeFirst(8)
                chanelname.removeLast(1)
                return myCat
            }
        }
        return "error"
    }
    
func getChannelByNameOfCategory(categoryName: String){
        
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        _ =  FileManager.default.contents(atPath: String(destinationFileUrl.path))
        do {
            let SoureseFileText = try String(contentsOf: destinationFileUrl, encoding: .utf8)
            let NewString = SoureseFileText.components(separatedBy: "#")
            for i in NewString.indices{
                if i <= 1{
                    continue
                }
                    let NewCategory = NewString[i].components(separatedBy: " ")
                    let myCat = getCategory(findInString: NewCategory )
                    if categoryName == myCat
                    {
                        ChanelSelctedDict[getChannelNameByArray(findInString: NewCategory)] = getUrlByCategoty(findInString: NewCategory)
                    }
                }
            }catch
            {
                print("Errorlet converitng file")
            }
    }
    
    
    func getUrlByCategoty(findInString: Array<String>)-> String{
        for j in findInString.indices{
            if findInString[j].hasSuffix("m3u8\n"){
                var urli = findInString[j]
                var notUrl = false
                while(notUrl == false){
                    if(urli.prefix(4) != "http"){
                        urli.removeFirst(1)
                    }else{
                        notUrl = true
                        return urli
                    }
                }
            }
        }
        return "Error"
    }
    
    
    private func getChannelNameByArray(findInString: Array<String>) -> String{
        
        for j in findInString.indices{
            if findInString[j].prefix(7) == "tvg-id="{
                var chanelName = findInString[j]
                chanelName.removeFirst(8)
                print(chanelName)
                return chanelName
            }
        }
        return "Error"
    }
}


//      http://18a2fd3abc48.goodstreem.org/playlists/uplist/b079dc539247bf0e7b0783bafe67981f/playlist.m3u8
//
//      https://iptv-org.github.io/iptv/index.nsfw.m3u


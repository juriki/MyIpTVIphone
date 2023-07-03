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
    var ChanelDict: [String: String] = [:]
    var Cateroies: [String] = ["Favorite"]
    var ChanelSelctedDict: [String: String] = [:]
    
    func ReadFileFromMemory()
    {
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        let test  =  destinationFileUrl.path
        let myFile2 =  FileManager.default.contents(atPath: test)
        do {
               let text2 = try String(contentsOf: destinationFileUrl, encoding: .utf8)
            
            let newtext = text2.components(separatedBy: "#")
            
                for i in newtext.indices {
                    if (newtext[i].hasSuffix("m3u8\r\n"))
                    {
                        var notUrl = false
                        var ChaneCategory = newtext[i]
                        ChaneCategory.removeFirst(7)
                        guard let removeHttp = ChaneCategory.firstIndex(of: "h") else { return }
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
                        
                        for i in Cateroies.indices
                        {
                            var match = false
                            if(Cateroies[i] == String(category))
                            {
                                match = true
                            }
                            if(Cateroies.count == i+1 && match == false )
                            {
                                print(Cateroies.count)
                                Cateroies.append(String(category))
                            }
                        }
                        while(notUrl == false){
                            if(ChanelUrl.prefix(4) != "http")
                            {
                                ChanelUrl.removeFirst(1)
                                
                            }else
                            {
                                notUrl = true
                            }
                        }
                        ChanelDict.updateValue(ChanelUrl, forKey: category + " || " + ChanelName)
                    }
                }
            }
           catch {print("Error of converitng file")}
    }

    
    
    
    func DownlondFromUrl(fileURL: String){
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        //Create URL to the source file you want to download
        let fileURL = URL(string: "http://18a2fd3abc48.goodstreem.org/playlists/uplist/b079dc539247bf0e7b0783bafe67981f/playlist.m3u8")
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
    
    
    func getChanel(getByCategory: String)
    {
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        let test  =  destinationFileUrl.path
        let myFile =  FileManager.default.contents(atPath: test)

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
                    guard let removeHttp = ChaneCategory.firstIndex(of: "h") else { return }
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
        }
        sortDict()
    }
    
    
    func sortDict()
    {
        ChanelSelctedDict.sorted(by: { $0.0 < $1.0 })
    }
    
}

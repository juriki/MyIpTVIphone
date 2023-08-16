//
//  ViewController.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 21.6.2023.
//

import UIKit
import AVFoundation
import AVKit

@IBDesignable

class ViewController: UIViewController {

    @IBOutlet weak var HomeTVbutton: UIBarButtonItem!
    @IBOutlet weak var Input: UITextField!
    @IBOutlet weak var StacviewUp: UIStackView!
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var ButtonFirst: UIButton!
    let player = Player()
    let fileHandler = MtriUfileHandle()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        if(!fileHandler.ReadFileFromMemory())
        {
            HomeTVbutton.isHidden = true
        }
        if( fileHandler.ReadFileFromMemory())
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

        
    
    @IBAction func FirstChanelButton(_ sender: Any) {
        
        
        if(Input.text!.count >= 20)
        {
            fileHandler.deleteFileFromMemory()
            fileHandler.DownlondFromUrl(myFileURL: Input.text!)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
 
}


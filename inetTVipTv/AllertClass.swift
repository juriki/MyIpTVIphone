//
//  AllertClass.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 26.9.2023.
//
//
//  CollectionViewController.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 29.6.2023.
//

import UIKit


class AllertClass: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    
    func showAlertWithTF() {
            let alertController = UIAlertController(title: "Add new Items", message: nil, preferredStyle: .alert)
            let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
                if let txtField = alertController.textFields?.first, let text = txtField.text {
                    // operations
                      
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            alertController.addTextField { (textField) in
                textField.placeholder = "Pasword"
            }
            let cancelAction1 = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            alertController.addTextField { (textField) in
                textField.placeholder = "retype Password"
            }
            alertController.addAction(addAction)
            alertController.addAction(cancelAction)
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
              
        }
    
    
}

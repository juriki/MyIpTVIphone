//
//  AnimationViewController.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 15.8.2023.
//

import UIKit


class AnimationViewController: UIViewController {
    
    @IBOutlet weak var animationImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(animationImage)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        animationImage.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            self.animate()
        })
    }
    
    func animate(){
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.animationImage.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            self.animationImage.alpha = 0
        })
        
    }
}

//
//  AnimationViewController.swift
//  inetTVipTv
//
//  Created by Jurij Tokvin on 15.8.2023.
//

import UIKit


class AnimationViewController: UIViewController {
    
    let fileHandler = MtriUfileHandle()

    
    private let animationImage: UIImageView = {
        
        let animationImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 200))
        animationImage.image = UIImage(named: "tv2")
        animationImage.contentMode = .scaleAspectFit
        return animationImage
    }()
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        view.addSubview(animationImage)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animationImage.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
            self.animate()
        })
    }
    
    func animate(){
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 2.5
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
        }, completion: { done in
            if done{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.7, execute:{
                      
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                self.navigationController?.pushViewController(vc, animated: false)
                     
                })
            }
        })
        
    }
}

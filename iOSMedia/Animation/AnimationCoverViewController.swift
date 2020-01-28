//
//  AnimationCoverViewController.swift
//  iOSMedia
//
//  Created by Julia García Martínez on 20/01/2020.
//  Copyright © 2020 Julia García Martínez. All rights reserved.
//

import UIKit

class AnimationCoverViewController: UIViewController {
    
    // MARK: Properties
    var viewBack: UIImageView!
    var viewFront: UIImageView!
    
    @IBOutlet weak var viewCover: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewFront = UIImageView(image: UIImage(named: "nyan_frontal.png")!)
        self.viewFront.frame = self.viewCover.bounds
        self.viewFront.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.viewBack = UIImageView(image: UIImage(named: "nyan_reverse.png")!)
        self.viewBack.frame = self.viewCover.bounds
        self.viewBack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.viewCover.addSubview(self.viewFront)
    }
    
    @IBAction func actionTurn(_ sender: UIButton) {
        
        if let _ = self.viewFront.superview {
            UIView.transition(from: self.viewFront,
            to: self.viewBack,
            duration: 1.5,
            options: .transitionFlipFromLeft,
            completion: { _ in })
        } else {
            UIView.transition(from: self.viewBack,
            to: self.viewFront,
            duration: 1.5,
            options: .transitionFlipFromRight,
            completion: { _ in })
        }
    }
    
    @IBAction func actionZoomOut(_ sender: UIButton) {
        UIView.animate(withDuration: 1, animations: {() -> Void in
            self.viewFront.bounds = CGRect(x: 0, y: 0, width: 256, height: 256)
            self.viewBack.bounds = CGRect(x: 0, y: 0, width: 256, height: 256)
        })
    }
    
    @IBAction func actionZoomIn(_ sender: UIButton) {
        UIView.animate(withDuration: 1, animations: {() -> Void in
            self.viewFront.bounds = CGRect(x: 0, y: 0, width: 512, height: 512)
            self.viewBack.bounds = CGRect(x: 0, y: 0, width: 512, height: 512)
        })
    }
    
}

//
//  AnimationViewController.swift
//  iOSMedia
//
//  Created by Julia García Martínez on 20/01/2020.
//  Copyright © 2020 Julia García Martínez. All rights reserved.
//

import UIKit
import QuartzCore

class AnimationViewController: UIViewController {
    
    // MARK: Properties
    var coverLayer: CALayer!
    @IBOutlet weak var buttonHere: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        drawLayerDog()
        drawLayerGrass()
    }
    
    func drawLayerDog() {
        self.coverLayer = CALayer()
        self.coverLayer.position = self.view.center
        self.coverLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        // Configuración del layer
        // 1. Radio de esquinas 10
        self.coverLayer.cornerRadius = 10
        // 2. Grosor de borde 2
        self.coverLayer.borderWidth = 2
        // 3. Color de fondo blanco
        self.coverLayer.backgroundColor = UIColor.white.cgColor
        // 4. Color de borde gris
        self.coverLayer.borderColor = UIColor.red.cgColor
        
        self.coverLayer.contents = (UIImage(named: "dog.png")!.cgImage! as Any)
        self.coverLayer.contentsGravity = CALayerContentsGravity.resizeAspect
        
        self.view.layer.addSublayer(self.coverLayer)
    }
    
    func drawLayerGrass() {
        
        var x = self.view.bounds.minX + 50
        let y = self.view.bounds.maxY - 100
        let sizeImageGrass: CGFloat = 64
        
        for _ in 1...5 {
            let grassLayer = CALayer()
            grassLayer.position = CGPoint(x: x, y: y)
            grassLayer.bounds = CGRect(x: 0, y: 0, width: sizeImageGrass, height: sizeImageGrass)
            
            grassLayer.contents = (UIImage(named: "grass.png")!.cgImage! as Any)
            grassLayer.contentsGravity = CALayerContentsGravity.resizeAspect
            
            self.view.layer.addSublayer(grassLayer)
            
            x += sizeImageGrass
        }
    }
    
    // MARK: Actions
    @IBAction func actionGoHere(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.coverLayer.position.x = sender.center.x
            self.coverLayer.position.y = sender.center.y
        })
    }

}

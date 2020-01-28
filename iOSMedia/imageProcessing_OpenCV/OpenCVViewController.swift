//
//  ViewController.swift
//  OpenCVGraficos
//
//  Created by Máster Móviles on 04/12/2019.
//  Copyright © 2019 Máster Móviles. All rights reserved.
//

import UIKit

class OpenCVViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btn_gris: UIButton!
    @IBOutlet weak var btn_cany: UIButton!
    @IBOutlet weak var btn_blur: UIButton!
    @IBOutlet weak var btn_detector: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func botonConvertirGrises(_ sender: UIButton) {
        btn_cany.isEnabled = false
        btn_blur.isEnabled = false
        btn_detector.isEnabled = false
        image.image = OpencvWrapper.grayScale(self.image!.image)
    }
    
    @IBAction func botonConvertirCany(_ sender: Any) {
        btn_gris.isEnabled = false
        btn_blur.isEnabled = false
        btn_detector.isEnabled = false
        image.image = OpencvWrapper.canyImage(self.image!.image)
    }
    
    @IBAction func botonConvertirBlur(_ sender: Any) {
        btn_cany.isEnabled = false
        btn_gris.isEnabled = false
        btn_detector.isEnabled = false
        image.image = OpencvWrapper.blurImage(self.image!.image)
    }
    
    @IBAction func botonDetectarCaras(_ sender: Any) {
        btn_cany.isEnabled = false
        btn_blur.isEnabled = false
        btn_gris.isEnabled = false
        image.image = OpencvWrapper.faceDetector(self.image!.image)
    }
    
    @IBAction func botonResetImage(_ sender: Any) {
        btn_gris.isEnabled = true
        btn_cany.isEnabled = true
        btn_blur.isEnabled = true
        btn_detector.isEnabled = true
        image.image = UIImage(named: "photo.jpg")
    }
    
}


//
//  ImageProcessingViewController.swift
//  iOSMedia
//
//  Created by Julia García Martínez on 22/01/2020.
//  Copyright © 2020 Julia García Martínez. All rights reserved.
//

import UIKit
import GLKit
import CoreImage

class ImageProcessingViewController: UIViewController, GLKViewDelegate {
    
    // MARK: Properties
    var contextGPU: CIContext?
    var contextCPU: CIContext?
    
    var originalImage: CIImage?
    var filteredImage: CIImage?
    
    var filter: CIFilter?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var glkView: GLKView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.originalImage = CIImage(image: UIImage(named: "image_to_process.png")!)
        self.imageView.image = UIImage(named: "image_to_process.png")
        
        let api: EAGLRenderingAPI = EAGLRenderingAPI.openGLES2
        let glContext = EAGLContext(api: api)
        
        self.glkView.context = glContext!;
        self.glkView.delegate = self;
        
        self.filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(self.originalImage, forKey: kCIInputImageKey)

        self.contextGPU = CIContext(eaglContext: glContext!)
        self.contextCPU = CIContext(options: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if self.filteredImage == nil {
            self.filteredImage = self.originalImage
        }
        
        self.glkView.display()
    }
    
    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        let dest = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width * view.contentScaleFactor, height: rect.size.height * view.contentScaleFactor)
        self.contextGPU?.draw(self.filteredImage!, in: dest, from: (self.filteredImage?.extent)!)
    }
    
    @IBAction func sliderCPU(_ sender: UISlider) {        filter?.setValue(self.originalImage, forKey: kCIInputImageKey)
        filter?.setValue(sender.value, forKey: kCIInputIntensityKey)
        
        if let cgimg = self.contextCPU?.createCGImage((filter?.outputImage)!, from: (filter?.outputImage?.extent)!) {
            let processedImage = UIImage(cgImage: cgimg)
            self.imageView.image = processedImage
        }
    }
    
    @IBAction func sliderGPU(_ sender: UISlider) {
        filter?.setValue(sender.value, forKey: kCIInputIntensityKey)
        
        self.filteredImage = CIImage(cgImage: (self.contextGPU?.createCGImage((filter?.outputImage)!, from: (filter?.outputImage?.extent)!))!)
        self.glkView.display()
    }
    
    @IBAction func actionSaveImage(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, nil, nil)
    }
    

}

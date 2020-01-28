//
//  VideoPlayerViewController.swift
//  iOSMedia
//
//  Created by Julia García Martínez on 20/01/2020.
//  Copyright © 2020 Julia García Martínez. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class VideoPlayerViewController: UIViewController {
    
    // MARK: Properties
    var moviePlayer: AVPlayerLayer?
    var videoURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.videoURL = Bundle.main.url(forResource: "video_cat", withExtension: "mp4")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
        }) { (context) in
            // TODO (b.3) Hacer que el tamaño del reproductor de AVPlayerLayer para que se ajuste al girar la pantalla.
            self.view.frame.size = size
            self.moviePlayer?.frame.size = size
        }
    }

    @objc func videoPlaybackDidFinish(_ notification: Notification) {
        self.moviePlayer?.removeFromSuperlayer()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        self.moviePlayer = nil
    }
    
    // MARK: Actions
    @IBAction func actionPlayVideo(_ sender: Any) {
        let player = AVPlayer(url: videoURL! as URL)
        let playerLayer = AVPlayerLayer(player: player)
        self.moviePlayer = playerLayer
        self.moviePlayer!.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoPlaybackDidFinish(_:)),  name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        self.moviePlayer?.backgroundColor = UIColor.gray.cgColor
    }
    
}

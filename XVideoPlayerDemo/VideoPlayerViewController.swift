//
//  VideoPlayerViewController.swift
//  XVideoPlayerDemo
//
//  Created by XiaAo on 2021/8/31.
//

import UIKit

class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var videoView: UIView!
    
    private var videoPlayerViewController = XVideoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func playVideo(_ sender: Any) {
        videoPlayerViewController.view.frame = videoView.bounds
        videoView.addSubview(videoPlayerViewController.view)
        videoPlayerViewController.setupPlayer()
        videoPlayerViewController.setVideoUrl("http://zhy-media.meldingcloud.com/video/720p/1706f391e736415abc25cce022660f93/transcode_1534406970207/b751afc3-11ca-4d8d-8d69-c314222fe4ee.mp4")
      //  videoPlayerViewController.setVideoUrl("http://playertest.longtailvideo.com/adaptive/bipbop/gear4/prog_index.m3u8")
        videoPlayerViewController.play()
    }
    
}

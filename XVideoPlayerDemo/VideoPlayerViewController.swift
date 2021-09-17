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
        videoPlayerViewController.setTitle("Video Play")
        videoPlayerViewController.setVideoUrl("https://mim-img3.cctv.cn/video/720p/3d78fe6326474775bc789c87dfbbf0c4/TRANSCODE_1615269129757/26c28f75-df67-487b-ae03-373ba025c20e.mp4")
//        videoPlayerViewController.setVideoUrl("http://playertest.longtailvideo.com/adaptive/bipbop/gear4/prog_index.m3u8")
        videoPlayerViewController.play()
    }
    
}

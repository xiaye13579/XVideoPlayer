//
//  XVideoViewController.swift
//  XVideoPlayerDemo
//
//  Created by XiaAo on 2021/9/1.
//

import UIKit
import AVFoundation

class XVideoViewController: UIViewController {
    
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    
    private var progressObserverToken: Any?
    
    var delegate: XVideoPlayerControllerDelegate?
    var isPlaying = false
    var isFullscreen = false
    var parentView : UIView?
    var controllerView: XVideoControlView?
    
    var videoUrl = "http://zhy-media.meldingcloud.com/video/720p/1706f391e736415abc25cce022660f93/transcode_1534406970207/b751afc3-11ca-4d8d-8d69-c314222fe4ee.mp4"

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player?.pause()
    }
    

    func setupPlayer(){
        let avPlayer = AVPlayer()
        setupPlayer(avPlayer)
    }
    
    func setupPlayer(_ avplayer: AVPlayer){
        player = avplayer
        playerLayer = AVPlayerLayer(player: player)
        if let playerLayer = playerLayer {
            playerLayer.videoGravity = .resizeAspect
            playerLayer.needsDisplayOnBoundsChange = true
            playerLayer.frame = view.bounds
            view.layer.addSublayer(playerLayer)
        }
        controllerView = Bundle(for: XVideoControlView.self).loadNibNamed(String(describing: XVideoControlView.self), owner: self, options: nil)?.last as? XVideoControlView
        controllerView?.frame = view.bounds
        controllerView?.backgroundColor = UIColor.clear
        controllerView?.playerViewController = self
        if let controllerView = controllerView {
            view.addSubview(controllerView)
        }
    }
    
    func setVideoUrl(_ url: String){
        videoUrl = url
        guard let playUrl = URL(string: videoUrl) else {
            debugPrint("URL is invalid")
            delegate?.onError(player: self, errorMessage: "URL is invalid")
            return
        }
        playerItem = AVPlayerItem(url: playUrl)
        player?.replaceCurrentItem(with: playerItem)
        initProgressObserver()
    }
    
    func play(){
        player?.play()
        delegate?.onEvent(player: self, event: XVideoPlayerEvent.play)
    }
    
    func pause(){
        player?.pause()
        delegate?.onEvent(player: self, event: XVideoPlayerEvent.pause)
    }
    
    func isLandscapeVideo() -> Bool{
        if let playerLayer = playerLayer {
            let videoWidth = playerLayer.videoRect.width
            let videoHeight = playerLayer.videoRect.height
            return videoWidth > videoHeight
        }
        return true
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return isLandscapeVideo() && isBeingPresented ? .landscapeRight : .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return isLandscapeVideo() && isBeingPresented ? .landscapeRight : .portrait
    }
    
    private func initProgressObserver(){
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        progressObserverToken = player?.addPeriodicTimeObserver(forInterval: time, queue: .main, using: { [weak self] time in
            debugPrint(time.seconds)
        })
    }
    
    func fullscreen(){
        if isFullscreen {
            dismiss(animated: false, completion: {[weak self] in
                if let self1 = self {
                    self1.view.layoutIfNeeded()
                    if let parentView = self1.parentView {
                        self1.view.frame = parentView.bounds
                    }
                    self1.parentView?.addSubview(self1.view)
                    self1.isFullscreen = false
                    self1.playerLayer?.frame = self1.view.bounds
                }
            })
        } else {
            if let topViewController = XVideoUtil.getTopViewController(){
                self.modalPresentationStyle = .fullScreen
                parentView = view.superview
                topViewController.present(self, animated: false, completion: {[weak self] in
                    self?.isFullscreen = true
                    self?.playerLayer?.layoutIfNeeded()
                    if let view = self?.view{
                        self?.playerLayer?.frame = view.bounds
                    }
                })
            }
            
        }
    }
    
    func playPause(){
        
    }

}

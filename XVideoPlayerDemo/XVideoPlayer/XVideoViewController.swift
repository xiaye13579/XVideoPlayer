//
//  XVideoViewController.swift
//  XVideoPlayerDemo
//
//  Created by XiaAo on 2021/9/1.
//

import UIKit
import AVFoundation

class XVideoViewController: UIViewController {
    
    private var playerRateContext = 11
    private var playerTimeControlContext = 22
    private var itemStatusContext = 33
    private var itemDurationContext = 44
    private var itemBufferEmptyContext = 55
    private var itemBufferFullContext = 66
    private var itemBufferLikelyToKeepUp = 77
    
    private var playerLayer: AVPlayerLayer?
    
    private var playerItem: AVPlayerItem?
    
    private var progressObserverToken: Any?
    private var player: AVPlayer?
    var delegate: XVideoPlayerControllerDelegate?
    var isFullscreen = false
    var parentView : UIView?
    var controllerView: XVideoControlView?
    
    var videoUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        let guesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        self.view.addGestureRecognizer(guesture)
    }
    
    @objc func tapGestureAction() {
        if controllerView?.isShowing == true {
            controllerView?.showHideFunctionView(false)
        } else {
            controllerView?.showHideFunctionView(true)
        }
    }
    
    func setupPlayer(){
        if let _ = player {
            player?.pause()
        } else {
            player = AVPlayer()
        }
        playerLayer?.removeFromSuperlayer()
        playerLayer = AVPlayerLayer(player: player)
        if let playerLayer = playerLayer {
            playerLayer.videoGravity = .resizeAspect
            playerLayer.needsDisplayOnBoundsChange = true
            playerLayer.frame = view.bounds
            view.layer.addSublayer(playerLayer)
        }
        controllerView?.removeFromSuperview()
        controllerView = Bundle(for: XVideoControlView.self).loadNibNamed(String(describing: XVideoControlView.self), owner: self, options: nil)?.last as? XVideoControlView
        controllerView?.frame = view.bounds
        controllerView?.backgroundColor = UIColor.clear
        controllerView?.playerViewController = self
        controllerView?.setup()
        if let controllerView = controllerView {
            view.addSubview(controllerView)
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch {
            debugPrint(error)
        }
       
    }
    
    func setupPlayer(_ avplayer: AVPlayer){
        player = avplayer
        setupPlayer()
    }
    
    func setVideoUrl(_ url: String){
        videoUrl = url
        guard let playUrl = URL(string: videoUrl) else {
            debugPrint("URL is invalid")
            delegate?.onError(self, errorMessage: "URL is invalid")
            return
        }
        playerItem = AVPlayerItem(url: playUrl)
        player?.replaceCurrentItem(with: playerItem)
        initProgressObserver()
        initObservers()
    }
    
    func setTitle(_ text: String){
        controllerView?.setTitle(text)
    }
    
    func play(){
        player?.play()
    }
    
    func pause(){
        player?.pause()
        delegate?.onEvent(self, event: XVideoPlayerEvent.pause)
    }
    
    func isLandscapeVideo() -> Bool{
        if let playerLayer = playerLayer {
            let videoWidth = playerLayer.videoRect.width
            let videoHeight = playerLayer.videoRect.height
            return videoWidth > videoHeight
        }
        return true
    }
    
    func isPlaying() -> Bool{
        return player?.timeControlStatus == .playing
    }
    
    func isMute() -> Bool{
        if let player = player {
            return player.isMuted
        }
        return false
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
        removeProgressObserver()
        progressObserverToken = player?.addPeriodicTimeObserver(forInterval: time, queue: .main, using: { [weak self] time in
            guard let self1 = self else {return}
            if self1.controllerView?.isSliderDragging == false {
                self1.controllerView?.setPlayTime(self1.progressToTime(time))
                self1.controllerView?.setSliderValue(Float(time.seconds))
            }
        })
    }
    
    private func initObservers(){
        setItemObservers(#keyPath(AVPlayerItem.status), context: &itemStatusContext)
        setItemObservers(#keyPath(AVPlayerItem.duration), context: &itemDurationContext)
        setItemObservers(#keyPath(AVPlayerItem.isPlaybackBufferEmpty), context: &itemBufferEmptyContext)
        setItemObservers(#keyPath(AVPlayerItem.isPlaybackBufferFull), context: &itemBufferFullContext)
        setItemObservers(#keyPath(AVPlayerItem.isPlaybackLikelyToKeepUp), context: &itemBufferLikelyToKeepUp)
        setPlayerObservers(#keyPath(AVPlayer.rate), context: &playerRateContext)
        setPlayerObservers(#keyPath(AVPlayer.timeControlStatus), context: &playerTimeControlContext)
    }
    
    func removeProgressObserver() {
        if let progressObserverToken = progressObserverToken {
            player?.removeTimeObserver(progressObserverToken)
            self.progressObserverToken = nil
        }
    }
    
    func removeAllObservers(){
        removeItemObservers(#keyPath(AVPlayerItem.status), context: &itemStatusContext)
        removeItemObservers(#keyPath(AVPlayerItem.duration), context: &itemDurationContext)
        removeItemObservers(#keyPath(AVPlayerItem.isPlaybackBufferEmpty), context: &itemBufferEmptyContext)
        removeItemObservers(#keyPath(AVPlayerItem.isPlaybackBufferFull), context: &itemBufferFullContext)
        removeItemObservers(#keyPath(AVPlayerItem.isPlaybackLikelyToKeepUp), context: &itemBufferLikelyToKeepUp)
        removePlayerObservers(#keyPath(AVPlayer.rate), context: &playerRateContext)
        removePlayerObservers(#keyPath(AVPlayer.timeControlStatus), context: &playerTimeControlContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else {return}
        guard let value = change?[.newKey] else {return}
        handleObserverValue(keyPath, value: value)
    }
    
    private func handleObserverValue(_ keyPath: String, value: Any?){
        guard let value = value else {return}
//        print("Observer: \(keyPath) : \(value)" )
        switch(keyPath){
//        case #keyPath(AVPlayerItem.status):
//            controllerView?.showHidePlayButton(AVPlayerItem.Status(rawValue: value as! Int) == .readyToPlay)
//            break
        case #keyPath(AVPlayer.timeControlStatus):
            handlePlayStatus(value as! Int)
        case #keyPath(AVPlayerItem.isPlaybackBufferEmpty):
            controllerView?.showLoading()
            delegate?.onEvent(self, event: .buffing)
        case #keyPath(AVPlayerItem.isPlaybackBufferFull):
            controllerView?.hideLoading()
            delegate?.onEvent(self, event: .endBuffing)
        case #keyPath(AVPlayerItem.isPlaybackLikelyToKeepUp):
            controllerView?.hideLoading()
            delegate?.onEvent(self, event: .endBuffing)
        case #keyPath(AVPlayerItem.duration):
            guard let duration = playerItem?.duration else {return}
            if duration.seconds > 0 {
                controllerView?.setSliderMaxValue(Float(duration.seconds))
                controllerView?.setDuration(progressToTime(duration))
            }
        default:
            break
        }
    }
    
    private func handlePlayStatus(_ status: Int) {
        let statusRaw = AVPlayer.TimeControlStatus.init(rawValue: status)
        controllerView?.setButtonStatus(statusRaw == .playing)
        switch (statusRaw) {
        case .playing:
            delegate?.onEvent(self, event: .play)
        case .paused:
            delegate?.onEvent(self, event: .pause)
        case .none:
            //            debugPrint("none")
            break
        case .some(_):
            //            debugPrint("nothing")
            break
        }
    }
    
    func fullscreen(){
        if isFullscreen {
            dismiss(animated: false, completion: {[weak self] in
                if let self1 = self {
                    self1.delegate?.onEvent(self1, event: .exitFullscreen)
                    self1.view.layoutIfNeeded()
                    if let parentView = self1.parentView {
                        self1.view.frame = parentView.bounds
                    }
                    self1.parentView?.addSubview(self1.view)
                    self1.isFullscreen = false
                    self1.playerLayer?.frame = self1.view.bounds
                    self1.controllerView?.setFullscreenStatus(false)
                }
            })
        } else {
            if let topViewController = XVideoUtil.getTopViewController(){
                self.modalPresentationStyle = .fullScreen
                parentView = view.superview
                
                topViewController.present(self, animated: false, completion: {[weak self] in
                    if let self1 = self {
                        self1.isFullscreen = true
                        self1.delegate?.onEvent(self1, event: .fullscreen)
                        self1.playerLayer?.layoutIfNeeded()
                        if let view = self?.view {
                            self1.playerLayer?.frame = view.bounds
                            self1.controllerView?.needsUpdateConstraints()
                            self1.controllerView?.layoutIfNeeded()
                        }
                        self1.controllerView?.setFullscreenStatus(true)
                        
                    }
                })
            }
        }
        
    }
    
    func mute() {
        player?.isMuted = !isMute()
        controllerView?.setMuteButtonStatus(isMute())
    }
    
    @objc func delayExecution(){
        controllerView?.showHideFunctionView(false)
    }
    
    func seekTo(second:Int) {
        player?.seek(to: CMTime(seconds: Double(second), preferredTimescale: 1))
    }
    
    func playPause(){
        self.perform(#selector(delayExecution), with: nil, afterDelay: 3)
        if isPlaying() {
            player?.pause()
        } else {
            player?.play()
        }
    }
    
    deinit {
        removeAllObservers()
        removeProgressObserver()
    }
}

extension XVideoViewController{
    func setItemObservers(_ keyPath: String, context: UnsafeMutableRawPointer){
        playerItem?.addObserver(self, forKeyPath: keyPath, options: [.old, .new], context: context)
    }
    
    func setPlayerObservers(_ keyPath: String, context: UnsafeMutableRawPointer){
        player?.addObserver(self, forKeyPath: keyPath, options: [.old, .new], context: context)
    }
    
    func removeItemObservers(_ keyPath: String, context: UnsafeMutableRawPointer){
        playerItem?.removeObserver(self, forKeyPath: keyPath,  context: context)
    }
    
    func removePlayerObservers(_ keyPath: String, context: UnsafeMutableRawPointer){
        player?.removeObserver(self, forKeyPath: keyPath, context: context)
    }
    
    func progressToTime(_ time: CMTime) -> String{
        let p = Int(time.seconds)
        let sec = p % 60
        let min = p / 60
        var secText = String(sec)
        if(sec < 10){
            secText = String("0\(sec)")
        }
        var minText = String(min)
        if(min < 10){
            minText = String("0\(min)")
        }
        return String("\(minText):\(secText)")
    }
}

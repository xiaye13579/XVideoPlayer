//
//  XVideoControlView.swift
//  XVideoPlayerDemo
//
//  Created by XiaAo on 2021/9/1.
//

import UIKit

class XVideoControlView: UIView {

    @IBOutlet private weak var buttonPlayPause: UIButton!
    @IBOutlet private weak var indicatorLoading: UIActivityIndicatorView!
    @IBOutlet private weak var viewBottomController: VideoFunctionView!
    @IBOutlet private weak var viewTopContainer: VideoFunctionView!
    @IBOutlet private weak var labelPlayTime: UILabel!
    @IBOutlet private weak var labelDuration: UILabel!
    @IBOutlet private weak var labelVideoTitle: UILabel!
    @IBOutlet private weak var buttonFullscreen: UIButton!
    @IBOutlet private weak var buttonMute: UIButton!
    @IBOutlet private weak var sliderProgress: ProgressSlider!
    
    weak var playerViewController: XVideoViewController?
    var isSliderDragging = false
    var isShowing = true

    func setup() {
        sliderProgress.isContinuous = false
    }

    @IBAction func playButtonClick(_ sender: Any) {
        playerViewController?.playPause()
    }
    
    @IBAction func fullscreenButtonClick(_ sender: Any) {
        playerViewController?.fullscreen()
    }
    
    @IBAction func muteButtonClick(_ sender: Any) {
        playerViewController?.mute()
    }
    

    @IBAction func sliderValueChange(_ sender: ProgressSlider, forEvent event: UIEvent) {
        playerViewController?.seekTo(second: Int(sliderProgress.value))
        if let touchEvent = event.allTouches?.first, touchEvent.phase == .moved {
            isSliderDragging = true
        } else {
            isSliderDragging = false
        }
    }
    
    func showLoading(){
        indicatorLoading.isHidden = false
        indicatorLoading.startAnimating()
    }
    
    func hideLoading(){
        indicatorLoading.isHidden = true
        indicatorLoading.stopAnimating()
    }
    
    func showHidePlayButton(_ show: Bool){
        buttonPlayPause.isHidden = !show
    }
    
    func setButtonStatus(_ playing: Bool){
        buttonPlayPause.setImage(UIImage(named: playing ? "pause.png" : "play.png"), for: .normal)
    }
    
    func setFullscreenStatus(_ fullscreen: Bool) {
        buttonFullscreen.setImage(UIImage(named: fullscreen ? "fullscreen_shrink.png" : "fullscreen_expand.png"), for: .normal)
    }
    
    func setMuteButtonStatus(_ mute: Bool){
        buttonMute.setImage(UIImage(named: mute ? "sound_mute.png" : "sound_on.png"), for: .normal)
    }
    
    func setPlayTime(_ string: String){
        labelPlayTime.text = string
    }
    
    func setDuration(_ string: String){
        labelDuration.text = string
    }
    
    func showHideFunctionView(_ show: Bool){
        debugPrint("showHideFunctionView:\(show)")
        if show {
            viewBottomController.fadeIn()
            viewTopContainer.fadeIn()
            showHidePlayButton(true)
            isShowing = true
        } else {
            viewBottomController.fadeOut()
            viewTopContainer.fadeOut()
            showHidePlayButton(false)
            isShowing = false
        }
    }
    
    func setTitle(_ text: String){
        labelVideoTitle.text = text
    }
    
    func setSliderMaxValue(_ value: Float){
        sliderProgress.maximumValue = value
    }
    
    func setSliderValue(_ value: Float){
        sliderProgress.value = value
    }
}

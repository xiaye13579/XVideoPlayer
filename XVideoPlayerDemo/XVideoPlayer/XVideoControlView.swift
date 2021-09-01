//
//  XVideoControlView.swift
//  XVideoPlayerDemo
//
//  Created by XiaAo on 2021/9/1.
//

import UIKit

class XVideoControlView: UIView {

    @IBOutlet weak var buttonPlayPause: UIButton!
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    @IBOutlet weak var viewBottomController: GradientView!
    @IBOutlet weak var labelPlayTime: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var buttonFullscreen: UIButton!
    @IBOutlet weak var buttonMute: UIButton!
    @IBOutlet weak var sliderProgress: ProgressSlider!
    
    weak var playerViewController: XVideoViewController?

    func setup() {

    }

    @IBAction func playButtonClick(_ sender: Any) {
        playerViewController?.playPause()
    }
    
    @IBAction func fullscreenButtonClick(_ sender: Any) {
        playerViewController?.fullscreen()
    }
    
    @IBAction func sliderChange(_ sender: ProgressSlider) {
        playerViewController?.seekTo(second: Int(sliderProgress.value))
    }
    
    func showLoading(){
        indicatorLoading.isHidden = false
        indicatorLoading.startAnimating()
    }
    
    func hideLoading(){
        indicatorLoading.isHidden = true
        indicatorLoading.stopAnimating()
    }
    
    func setButtonStatus(playing: Bool){
        buttonPlayPause.setImage(UIImage(named: playing ? "pause.png" : "play.png"), for: .normal)
    }
    
    func setPlayTime(_ string: String){
        labelPlayTime.text = string
    }
    
    func setDuration(_ string: String){
        labelDuration.text = string
    }
}

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
    @IBOutlet weak var buttonFullscreen: UIButton!
    
    weak var playerViewController: XVideoViewController?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func playButtonClick(_ sender: Any) {
        playerViewController?.playPause()
    }
    
    @IBAction func fullscreenButtonClick(_ sender: Any) {
        playerViewController?.fullscreen()
    }
    
    func showLoading(){
        indicatorLoading.isHidden = false
        indicatorLoading.startAnimating()
    }
    
    func hideLoading(){
        indicatorLoading.isHidden = true
        indicatorLoading.stopAnimating()
    }
    
    
    
}

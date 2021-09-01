//
//  XVideoPlayerControllerDelegate.swift
//  XVideoPlayerDemo
//
//  Created by XiaAo on 2021/8/31.
//

import Foundation

protocol XVideoPlayerControllerDelegate {
    func onEvent(_ player: XVideoViewController, event: XVideoPlayerEvent)
    func onError(_ player: XVideoViewController, errorMessage: String)
}

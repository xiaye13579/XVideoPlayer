//
//  XVideoPlayerEvent.swift
//  XVideoPlayerDemo
//
//  Created by XiaAo on 2021/8/31.
//

import Foundation

public enum XVideoPlayerEvent: Int {
    case error = 0
    case play = 1
    case pause = 2
    case buffing = 3
    case endBuffing = 4
    case fullscreen = 5
    case exitFullscreen = 6
}

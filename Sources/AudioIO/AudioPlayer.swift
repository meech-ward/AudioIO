//
//  AudioPlayer.swift
//  AudioIOPackageDescription
//
//  Created by Sam Meech-Ward on 2018-01-14.
//

import Foundation

public struct AudioPlayer {
  
  let playable: AudioPlayable
  
  public init(playable: AudioPlayable) {
    self.playable = playable
  }
  
  public func play() {
    playable.play()
  }
  
  public func stop() {
    playable.stop()
  }
}

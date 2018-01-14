//
//  AudioPlayer.swift
//  AudioIOPackageDescription
//
//  Created by Sam Meech-Ward on 2018-01-14.
//

import Foundation

public struct AudioPlayer {
  
  let playable: AudioPlayable
  
  public var currentTime: TimeInterval {
    return playable.currentTime
  }
  
  public init(playable: AudioPlayable) {
    self.playable = playable
  }
  
  public func play(closure: (@escaping (_ successfully: Bool) -> ()) = {_ in }) {
    playable.play() { successful in
      closure(successful)
    }
  }
  
  public func stop(closure: (@escaping (_ successfully: Bool) -> ()) = {_ in }) {
    playable.stop() { successful in
      closure(successful)
    }
  }
}

//
//  AudioPlayer.swift
//  AudioIOPackageDescription
//
//  Created by Sam Meech-Ward on 2018-01-14.
//

import Foundation

public struct AudioPlayer {
  
  // MARK: Public vars
  
  /// The current playhead time of the file that's being played.
  public var currentTime: TimeInterval {
    return playable.currentTime
  }
  
  /// The total duration of the audio file
  public var duration: TimeInterval {
    return playable.duration
  }
  
  /// True if the file is playing, false otherwise.
  public var isPlaying: Bool {
    return playable.isPlaying
  }
  
  // MARK: Private vars
  
  let playable: AudioPlayable
  
  // MARK: 👩‍💻
  
  public init(playable: AudioPlayable) {
    self.playable = playable
  }
  
  public func prepare() {
    self.playable.prepare()
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

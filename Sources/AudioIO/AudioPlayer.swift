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
  
  public var startTime: TimeInterval {
    guard let audioSection = audioSection else {
      return -1
    }
    return audioSection.startTime
  }
  
  public var endTime: TimeInterval {
    guard let audioSection = audioSection else {
      return -1
    }
    return audioSection.endTime
  }
  
  // MARK: Private vars
  
  let playable: AudioPlayable
  let audioSection: AudioSectionType?
  
  // MARK: 👩‍💻
  
  public init(playable: AudioPlayable, audioSection: AudioSectionType? = nil) {
    self.playable = playable
    self.audioSection = audioSection
  }
  
  /// Do any preperation required before playing
  public func prepare() {
    guard let audioSection = self.audioSection else {
      self.playable.prepare()
      return
    }
    
    self.playable.prepare(startTime: audioSection.startTime, endTime: audioSection.endTime)
  }
  
  /**
  */
  public func play(closure: (@escaping (_ successfully: Bool) -> ()) = {_ in }) {
    guard let audioSection = self.audioSection else {
      playable.play() { successful in
        closure(successful)
      }
      return
    }
    
    playable.play(startTime: audioSection.startTime,
                  endTime: audioSection.endTime) { successful in
                    closure(successful)
    }
  }
  
  public func stop(closure: (@escaping (_ successfully: Bool) -> ()) = {_ in }) {
    playable.stop() { successful in
      closure(successful)
    }
  }
  
  public func restart(closure: (@escaping (_ successfully: Bool) -> ()) = {_ in }) {
    playable.stop() { successful in
      closure(successful)
      guard successful else {
        return
      }
      self.playable.play() { successful in
        closure(successful)
      }
    }
  }
}

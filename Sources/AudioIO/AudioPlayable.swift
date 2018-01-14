//
//  AudioPlayable.swift
//  AudioIOPackageDescription
//
//  Created by Sam Meech-Ward on 2018-01-14.
//

import Foundation

public protocol AudioPlayable {
  
  /// Start Playing
  func play(closure: (@escaping (_ successfully: Bool) -> ()))
  
  /// Stop Playing
  func stop(closure: (@escaping (_ successfully: Bool) -> ()))
  
  /// The time, in seconds, since the beginning of the playing.
  var currentTime: TimeInterval { get }
  
  /// True if recording, false otherwise.
//  var isRecording: Bool { get }
}

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
  func play(startTime: TimeInterval, endTime: TimeInterval, closure: @escaping ((Bool) -> ()))
  
  /// Stop Playing
  func stop(closure: (@escaping (_ successfully: Bool) -> ()))
  
  /// Do any preparation that is required to play
  func prepare()
  func prepare(startTime: TimeInterval, endTime: TimeInterval)
  
  /// The time, in seconds, since the beginning of the playing.
  var currentTime: TimeInterval { get }
  
  /// The duration, in seconds, of the entire file.
  var duration: TimeInterval { get }
  
  /// True if playing, false otherwise.
  var isPlaying: Bool { get }
}

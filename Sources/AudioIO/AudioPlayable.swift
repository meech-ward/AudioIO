//
//  AudioPlayable.swift
//  AudioIOPackageDescription
//
//  Created by Sam Meech-Ward on 2018-01-14.
//

import Foundation

public protocol AudioPlayable {
  /// Start playing
  func play()
  /// Stop playing
  func stop()
  
  /// Start Playing
  func play(closure: (@escaping (_ successfully: Bool) -> ()))
  
  /// Stop Playing
  func stop(closure: (@escaping (_ successfully: Bool) -> ()))
}

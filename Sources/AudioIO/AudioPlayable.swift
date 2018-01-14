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
}

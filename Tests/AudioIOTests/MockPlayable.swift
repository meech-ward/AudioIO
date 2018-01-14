//
//  MockPlayable.swift
//  AudioIOTests
//
//  Created by Sam Meech-Ward on 2018-01-14.
//

@testable import AudioIO
import Foundation

class MockPlayable: AudioPlayable {
  
  var currentTime: TimeInterval = -1
  var playClosure: ((Bool) -> ())?
  var stopClosure: ((Bool) -> ())?
  var isPlaying: Bool = false
  var duration: Double = -1
  
  var started = false
  var stopped = false
  
  func play() {
    started = true
    stopped = false
  }
  func stop() {
    started = false
    stopped = true
  }

  func play(closure: @escaping ((Bool) -> ()) = {_ in }) {
    started = true
    stopped = false
    playClosure = closure
    isPlaying = true
  }
  func stop(closure: @escaping ((Bool) -> ()) = {_ in }) {
    started = false
    stopped = true
    stopClosure = closure
    isPlaying = false
  }
}


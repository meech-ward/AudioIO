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
  var playClosure: ((Bool) -> ())? {
    didSet {
      playClosureUpdated?(playClosure!)
    }
  }
  var stopClosure: ((Bool) -> ())? {
    didSet {
      stopClosureUpdated?(stopClosure!)
    }
  }
  var playClosureUpdated: (((Bool) -> ()) -> (Void))?
  var stopClosureUpdated: (((Bool) -> ()) -> (Void))?
  
  var runClosuresImidiatly = false
  var isPlaying: Bool = false
  var duration: Double = -1
  
  var started = false
  var stopped = false
  
  var hasStarted = false
  var hasStopped = false
  
  var prepared = false
  
  func prepare() {
    prepared = true
  }
  
  var preparedStartTime: TimeInterval?
  var preparedEndTime: TimeInterval?
  func prepare(startTime: TimeInterval, endTime: TimeInterval) {
    preparedStartTime = startTime
    preparedEndTime = endTime
  }

  func play(closure: @escaping ((Bool) -> ()) = {_ in }) {
    started = true
    stopped = false
    hasStarted = true
    isPlaying = true
    playClosure = closure
  }
  
  var playedStartTime: TimeInterval?
  var playedEndTime: TimeInterval?
  func play(startTime: TimeInterval, endTime: TimeInterval, closure: @escaping ((Bool) -> ()) = {_ in }) {
    playedStartTime = startTime
    playedEndTime = endTime
  }
  
  func stop(closure: @escaping ((Bool) -> ()) = {_ in }) {
    started = false
    stopped = true
    hasStopped = true
    isPlaying = false
    stopClosure = closure
  }
}


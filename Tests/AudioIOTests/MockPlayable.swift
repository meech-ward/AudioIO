//
//  MockPlayable.swift
//  AudioIOTests
//
//  Created by Sam Meech-Ward on 2018-01-14.
//

@testable import AudioIO
import Foundation

class MockPlayable: AudioPlayable {
  
//  var currentTime: TimeInterval = 0
//  var startClosure: ((Bool) -> ())?
//  var stopClosure: ((Bool) -> ())?
//  var isRecording: Bool = false
//  
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
//
//  func start(closure: @escaping ((Bool) -> ()) = {_ in }) {
//    started = true
//    startClosure = closure
//  }
//  func stop(closure: @escaping ((Bool) -> ()) = {_ in }) {
//    stopped = true
//    stopClosure = closure
//  }
}


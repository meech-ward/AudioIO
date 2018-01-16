//
//  MockRecordable.swift
//  AudioProcessorTests
//
//  Created by Sam Meech-Ward on 2017-11-25.
//

@testable import AudioIO
import Foundation

class MockRecordable: AudioRecordable {
  
  var currentTime: TimeInterval = 0
  var startClosure: ((Bool) -> ())?
  var stopClosure: ((Bool) -> ())?
  var isRecording: Bool = false
  
  var started = false
  var stopped = false
  
  var deleted = false
  var deletedClosure: ((Bool) -> ())?
  
  func start(closure: @escaping ((Bool) -> ()) = {_ in }) {
    started = true
    isRecording = true
    startClosure = closure
  }
  func stop(closure: @escaping ((Bool) -> ()) = {_ in }) {
    stopped = true
    isRecording = false
    stopClosure = closure
  }
  func delete(closure: @escaping ((Bool) -> ()) = {_ in }) {
    deleted = true
    deletedClosure = closure
  }
}

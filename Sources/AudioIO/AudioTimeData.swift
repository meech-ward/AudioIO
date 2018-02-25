//
//  TimeData.swift
//  AudioProcessorTests
//
//  Created by Sam Meech-Ward on 2017-11-25.
//

import Foundation

public struct AudioTimeData {
  public let startTime: TimeInterval
  public let endTime: TimeInterval
  
  public init(startTime: TimeInterval, endTime: TimeInterval) {
    self.startTime = startTime
    self.endTime = endTime
  }
}

//
//  AudioSectionType.swift
//  AudioIOPackageDescription
//
//  Created by Sam Meech-Ward on 2018-01-15.
//

import Foundation

public protocol AudioSectionType {
  var startTime: TimeInterval { get }
  var endTime: TimeInterval { get }
}

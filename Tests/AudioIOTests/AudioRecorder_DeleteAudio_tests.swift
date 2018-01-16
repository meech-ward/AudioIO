//
//  AudioRecorder_DeleteAudio_tests.swift
//  AudioIOTests
//
//  Created by Sam Meech-Ward on 2018-01-16.
//
import XCTest
import Observe
import Focus
@testable import AudioIO


class AudioRecorder_DeleteAudio_tests: XCTestCase {
  
  override class func setUp() {
    Focus.defaultReporter().failBlock = XCTFail
  }
  
  func testSpec() {
    describe("AudioRecorder") {
      
      when("initialized with an AudioRecordable") {
        
        var audioRecorder: AudioRecorder!
        var mockRecordable: MockRecordable!
        beforeEach {
          mockRecordable = MockRecordable()
          audioRecorder = AudioRecorder(recordable: mockRecordable)
        }
        
        func delete(_ status: Bool = true) -> (called: Bool, success: Bool) {
          var called = false
          var success = false
          audioRecorder.delete { flag in
            called = true
            success = flag
          }
          mockRecordable.deletedClosure?(status)
          return (called, success)
        }
        
        describe("#delete()") {
          it("should call the delete method on the recordable") {
            expect(delete().called).to.be.true()
          }
          
          when("recordable fails to delete") {
            it("should not be successfull") {
              expect(delete(false).success).to.be.false()
            }
          }
          
          when("recordable succeeds to delete") {
            it("should be successfull") {
              expect(delete(true).success).to.be.true()
            }
          }
        }
        
        when("audio is recording") {
          beforeEach {
            audioRecorder.start()
          }
          it("should do nothing") {
            expect(delete().called).to.be.false()
          }
        }
      }
    }
  }
  
  static var allTests = [("testSpec", testSpec),]
}



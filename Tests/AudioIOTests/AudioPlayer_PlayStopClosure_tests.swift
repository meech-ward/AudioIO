import XCTest
import Observe
import Focus
@testable import AudioIO

class AudioPlayer_PlayStopClosure_tests: XCTestCase {
  
  override class func setUp() {
    Focus.defaultReporter().failBlock = XCTFail
  }
  
  func testSpec() {
    describe("AudioPlayer") {
      
      context("when initialized with an AudioPlayable") {
        
        var player: AudioPlayer!
        var playable: MockPlayable!
        beforeEach {
          playable = MockPlayable()
          player = AudioPlayer(playable: playable)
        }
        
        describe("#play()") {
          context("when player is stopped") {
            beforeEach {
              player.stop()
            }
            it("should call play on the playable") {
              player.play()
              expect(playable.started).to.be.true()
              expect(playable.stopped == false).to.be.true()
            }
          }
          //          context("when passed a start closure") {
          //            context("when the playable calls its start closure") {
          //              it("should call the start closure ") {
          //                var started = false
          //                audioRecorder.start() { _ in
          //                  started = true
          //                }
          //                mockRecordable.startClosure?(true)
          //                expect(started).to.be.true()
          //              }
          //              it("should pass in false when the recordable passes false") {
          //                var result = true
          //                audioRecorder.start() { flag in
          //                  result = flag
          //                }
          //                mockRecordable.startClosure?(false)
          //                expect(result != true).to.be.true()
          //              }
          //              it("should pass in true when the recordable passes true") {
          //                var result = false
          //                audioRecorder.start() { flag in
          //                  result = flag
          //                }
          //                mockRecordable.startClosure?(true)
          //                expect(result).to.be.true()
          //              }
          //            }
          //          }
        }
        
        describe("#stop()") {
          context("when player is playing") {
            beforeEach {
              player.play()
            }
            it("should call stop on the playable") {
              player.stop()
              expect(playable.started == false).to.be.true()
              expect(playable.stopped == true).to.be.true()
            }
          }
          
          //          context("when passed a stop closure") {
          //            context("when the recordable calls its stop closure") {
          //              it("should call the start closure ") {
          //                var stopped = false
          //                audioRecorder.stop() { _ in
          //                  stopped = true
          //                }
          //                mockRecordable.stopClosure?(true)
          //                expect(stopped).to.be.true()
          //              }
          //              it("should pass in false when the recordable passes false") {
          //                var result = true
          //                audioRecorder.stop() { flag in
          //                  result = flag
          //                }
          //                mockRecordable.stopClosure?(false)
          //                expect(result != true).to.be.true()
          //              }
          //              it("should pass in true when the recordable passes true") {
          //                var result = false
          //                audioRecorder.stop() { flag in
          //                  result = flag
          //                }
          //                mockRecordable.stopClosure?(true)
          //                expect(result).to.be.true()
          //              }
          //            }
          //          }
        }
      }
    }
  }
  
  static var allTests = [("testSpec", testSpec),]
  
}

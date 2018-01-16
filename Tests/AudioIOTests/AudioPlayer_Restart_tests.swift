import XCTest
import Observe
import Focus
@testable import AudioIO


class AudioPlayer_Restart_tests: XCTestCase {
  
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
        
        describe("#restart") {
          context("when play and stop happens successfully") {
            beforeEach {
              playable.playClosureUpdated = { closure in
                closure(true)
              }
              playable.stopClosureUpdated = { closure in
                closure(true)
              }
            }
            it("should not give an error") {
              player.restart() { successfull in
                expect(successfull).to.be.true()
              }
            }
            it("should stop and restart the playable") {
              player.restart()
              expect(playable.hasStarted).to.be.true()
              expect(playable.hasStopped).to.be.true()
              expect(playable.started).to.be.true()
              expect(playable.stopped).to.be.false()
            }
          }
          
          context("when play is successfull and stop isn't") {
            beforeEach {
              playable.playClosureUpdated = { closure in
                closure(true)
              }
              playable.stopClosureUpdated = { closure in
                closure(false)
              }
            }
            it("should give an error") {
              var successful = true
              player.restart() { flag in
                successful = flag
              }
              expect(successful).to.be.false()
            }
            it("should try and stop but fail") {
              player.restart()
              expect(playable.hasStopped).to.be.true()
              expect(playable.hasStarted).to.be.false()
              expect(playable.stopped).to.be.true()
            }
            
          }
          
          context("when stop is successfull and play isn't") {
            beforeEach {
              playable.playClosureUpdated = { closure in
                closure(false)
              }
              playable.stopClosureUpdated = { closure in
                closure(true)
              }
            }
            it("should give an error") {
              var successful = true
              player.restart() { flag in
                successful = flag
              }
              expect(successful).to.be.false()
            }
            it("should try and stop but fail") {
              player.restart()
              expect(playable.hasStopped).to.be.true()
              expect(playable.hasStarted).to.be.true()
              expect(playable.started).to.be.true()
            }
            
          }
        }
      }
    }
  }
  
  static var allTests = [("testSpec", testSpec),]
}


import XCTest
import Observe
import Focus
@testable import AudioIO


class AudioPlayer_tests: XCTestCase {
  
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
        
        describe(".currentTime") {
          it("should return the current time of the audio file") {
            playable.currentTime = 0.0
            expect(player.currentTime == 0.0).to.be.true()
            playable.currentTime = 1.0
            expect(player.currentTime == 1.0).to.be.true()
            playable.currentTime = 1.2
            expect(player.currentTime == 1.2).to.be.true()
          }
        }
        
        describe(".isPlaying") {
          context("when the file is playing") {
            it("should return true") {
              player.play()
              expect(player.isPlaying).to.be.true()
            }
          }
          context("when the file is not playing") {
            it("should return false") {
              player.stop()
              expect(player.isPlaying == false).to.be.true()
            }
          }
        }
        
        describe(".duration") {
          it("should return the playable's duration") {
            playable.duration = 0
            expect(player.duration == 0).to.be.true()
            playable.duration = 1
            expect(player.duration == 1).to.be.true()
            playable.duration = 1.2
            expect(player.duration == 1.2).to.be.true()
          }
        }
        
        describe("#prepare") {
          it("should call prepare on the playable") {
            player.prepare()
            expect(playable.prepared).to.be.true()
          }
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
              expect(playable.stopped == false).to.be.true()
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
              expect(successful == false).to.be.true()
            }
            it("should try and stop but fail") {
              player.restart()
              expect(playable.hasStopped).to.be.true()
              expect(playable.hasStarted == false).to.be.true()
              expect(playable.stopped).to.be.true()
            }
            
          }
        }
      }
    }
  }
  
  static var allTests = [("testSpec", testSpec),]
}

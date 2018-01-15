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
            expect(player.currentTime).to.equal(0.0)
            playable.currentTime = 1.0
            expect(player.currentTime).to.equal(1.0)
            playable.currentTime = 1.2
            expect(player.currentTime).to.equal(1.2)
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
              expect(player.isPlaying).to.be.false()
            }
          }
        }
        
        describe(".duration") {
          it("should return the playable's duration") {
            playable.duration = 0.0
            expect(player.duration).to.equal(0.0)
            playable.duration = 1.0
            expect(player.duration).to.equal(1.0)
            playable.duration = 1.2
            expect(player.duration).to.equal(1.2)
          }
        }
        
        describe("#prepare") {
          it("should call prepare on the playable") {
            player.prepare()
            expect(playable.prepared).to.be.true()
          }
        }
      }
    }
  }
  
  static var allTests = [("testSpec", testSpec),]
}

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
        
        it("should return the current time of the audio file") {
          playable.currentTime = 0.0
          expect(player.currentTime == 0.0).to.be.true()
          playable.currentTime = 1.0
          expect(player.currentTime == 1.0).to.be.true()
          playable.currentTime = 1.2
          expect(player.currentTime == 1.2).to.be.true()
        }
        
        it("should return the if the file is playing or not") {
          
        }
      }
    }
  }
  
  static var allTests = [("testSpec", testSpec),]
}

import XCTest
import Observe
import Focus
@testable import AudioIO

class AudioPlayer_PitchShifting_tests: XCTestCase {
  
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
      }
    }
  }
}

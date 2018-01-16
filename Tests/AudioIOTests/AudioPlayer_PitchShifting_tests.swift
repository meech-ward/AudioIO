import XCTest
import Observe
import Focus
@testable import AudioIO

class MockPitchShifter: PitchShifterType {
  var pitch = -1.0
}

class AudioPlayer_PitchShifting_tests: XCTestCase {
  
  override class func setUp() {
    Focus.defaultReporter().failBlock = XCTFail
  }
  
  func testSpec() {
    describe("AudioPlayer") {
      when("initialized with an AudioPlayable") {
        and("a pitch shifter") {
          var player: AudioPlayer!
          var playable: MockPlayable!
          var pitchShifter: MockPitchShifter!
          
          beforeEach {
            playable = MockPlayable()
            pitchShifter = MockPitchShifter()
            player = AudioPlayer(playable: playable, pitchShifter: pitchShifter)
          }
          
          describe(".pitch") {
            it("should set the pitch shifter's pitch") {
              player.pitch = 0.0
              expect(pitchShifter.pitch).to.equal(0)
              player.pitch = 1.0
              expect(pitchShifter.pitch).to.equal(1)
              player.pitch = 1.2
              expect(pitchShifter.pitch).to.equal(1.2)
            }
            it("should return the pitch shifter's pitch") {
              pitchShifter.pitch = 0.0
              expect(player.pitch).to.equal(0)
              pitchShifter.pitch = 1.0
              expect(player.pitch).to.equal(1)
              pitchShifter.pitch = 1.2
              expect(player.pitch).to.equal(1.2)
            }
          }
        }
      }
    }
  }
}

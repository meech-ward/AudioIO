import XCTest
import Observe
import Focus
@testable import AudioIO

class MockAudioSection: AudioSectionType {
  var startTime = 0.0
  var endTime = 0.0
}


class AudioPlayer_Section_tests: XCTestCase {
  
  override class func setUp() {
    Focus.defaultReporter().failBlock = XCTFail
  }
  
  func testSpec() {
    describe("AudioPlayer") {
      when("initialized with an AudioPlayable") {
        and("an audio section") {
          var player: AudioPlayer!
          var playable: MockPlayable!
          var audioSection: MockAudioSection!
          beforeEach {
            playable = MockPlayable()
            audioSection = MockAudioSection()
            player = AudioPlayer(playable: playable, audioSection: audioSection)
          }
          
          it("should have a start time equal to the audio section") {
            audioSection.startTime = 0.0
            expect(player.startTime).to.equal(0.0)
            audioSection.startTime = 1.0
            expect(player.startTime).to.equal(1.0)
            audioSection.startTime = 1.2
            expect(player.startTime).to.equal(1.2)
          }
          
          it("should have an end time equal to the audio section") {
            audioSection.endTime = 0.0
            expect(player.endTime).to.equal(0.0)
            audioSection.endTime = 1.0
            expect(player.endTime).to.equal(1.0)
            audioSection.endTime = 1.2
            expect(player.endTime).to.equal(1.2)
          }
          
          describe("#prepare") {
            func expectAudioSectionPrepare(startTime: TimeInterval, endTime: TimeInterval) {
              audioSection.startTime = startTime
              audioSection.endTime = endTime
              player.prepare()
              expect(playable.preparedStartTime!).to.equal(startTime)
              expect(playable.preparedEndTime!).to.equal(endTime)
            }
            it("should prepare the audio playable with the start and end time") {
              expectAudioSectionPrepare(startTime: 0.0, endTime: 0.0)
              expectAudioSectionPrepare(startTime: 0.0, endTime: 1.0)
              expectAudioSectionPrepare(startTime: 1.2, endTime: 2.5)
            }
            
            it("should only call the prepare with start and end time") {
              player.prepare()
              expect(playable.prepared).to.be.false()
            }
          }
          
          describe("#play") {
            it("should play the audio playable with the start and end time") {
              
            }
          }
        }
      }
    }
  }
}

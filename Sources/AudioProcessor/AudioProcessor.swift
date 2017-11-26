
import Foundation

enum AudioProcessorError: Error {
    case noData
    case noAmplitudeData
}

struct AudioProcessor {
    let samples: [AudioSample]
    
    init(samples: [AudioSample]) {
        self.samples = samples
    }
    
    func processBasedOnAmplitude() throws -> AudioTimeData {
        if samples.isEmpty {
            throw AudioProcessorError.noData
        }
        
        for sample in samples {
            guard let _ = sample.amplitude else {
                throw AudioProcessorError.noAmplitudeData
            }
        }
        
        var start: TimeInterval = samples.first!.time
        var end: TimeInterval = samples.last!.time
        
        let biggestSample = self.largestSample()
        let smallestSample = self.smallestSample()
        
        if smallestSample.amplitude! == biggestSample.amplitude!  {
            return AudioTimeData(startTime: start, endTime: end)
        }
        
        let lastPeakIndex = self.lastPeakIndex(peakSample: biggestSample, valleySample: smallestSample)
        
        // End time
        for i in lastPeakIndex..<samples.count {
            let sample = samples[i]

            if (sample.amplitude! == smallestSample.amplitude!)  {
                end = sample.time
                break
            }
        }
        
//        var averageChangeBetweenSamples
        // Start Time
        for i in (0..<lastPeakIndex).reversed() {
            let sample = samples[i]

            if (sample.amplitude! <= smallestSample.amplitude!)  {
                start = samples[i+1].time
                break
            }
        }
        
        return AudioTimeData(startTime: start, endTime: end)
    }
}

extension AudioProcessor {
    
    private func largestSample() -> AudioSample {
        return samples.reduce(AudioSample(time: 0, amplitude: 0)) { initial, next in
            if initial.amplitude! < next.amplitude! {
                return next
            }
            return initial
        }
    }
    
    private func smallestSample() -> AudioSample {
        return samples.reduce(AudioSample(time: 0, amplitude: 0)) { initial, next in
            if initial.amplitude! > next.amplitude! {
                return next
            }
            return initial
        }
    }
    
    private func lastPeakIndex(peakSample: AudioSample, valleySample: AudioSample) -> Int {
        var inMainAudio = false
        var lastPeakIndex: Int = 0
        for (index, sample) in samples.enumerated() {
            if sample.amplitude! == peakSample.amplitude!  && inMainAudio == false {
                inMainAudio = true
                lastPeakIndex = index
            } else if (sample.amplitude! == valleySample.amplitude!) && (inMainAudio == true) {
                inMainAudio = false
            }
        }
        
        return lastPeakIndex
    }
    
    func averageAmplitudeChangeBetweenSamples() -> (positive: Double, negative: Double) {
        if samples.count == 0 {
            return (0, 0)
        }
        
        var totalNegativeChanges = 0
        var totalNegativeAmplitudeChange = 0.0
        var totalPositiveChanges = 0
        var totalPositiveAmplitudeChange = 0.0
        for (index, currentSample) in samples.enumerated() {
            if (index == 0) {
                continue
            }
            let lastSample = samples[index-1]
            
            guard let currentAmplitude = currentSample.amplitude else {
                continue
            }
            guard let lastAmplitude = lastSample.amplitude else {
                continue
            }
            
            let difference = currentAmplitude - lastAmplitude
            
            if difference < 0 {
                totalNegativeChanges += 1
                totalNegativeAmplitudeChange += (difference*(-1))
            } else if difference > 0 {
                totalPositiveChanges += 1
                totalPositiveAmplitudeChange += difference
            }
            
        }
        
        var positiveAverage: Double
        if Double(totalPositiveChanges) == 0 {
            positiveAverage = 0
        } else {
           positiveAverage = totalPositiveAmplitudeChange/Double(totalPositiveChanges)
        }
        
        var negativeAverage: Double
        if Double(totalNegativeChanges) == 0 {
            negativeAverage = 0
        } else {
            negativeAverage = totalNegativeAmplitudeChange/Double(totalNegativeChanges)
        }
        return (positiveAverage, negativeAverage)
    }
}

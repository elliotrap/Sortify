import Foundation
import SwiftUI

class SortifyViewModel: ObservableObject {
    
    @ObservedObject var cvm = ColorViewModel()
    
    @Published var algoButtonPressed = false 
    @Published var expand3 = false
    @Published var expand2 = false
    @Published var expand = false
    
    @Published var data = [Int]()

    
    @Published var resetTime: Double = 0
    @Published var sliderValue: Double = 49.9999999999
    @Published var isSorting = false
    @Published var activeValue = 0
    @Published var previousValue = 0
    @Published var swoop: Int?
    
    @Published var animationAmount: CGFloat = 1
    @Published var toggleGraph = false
    @Published var showGraph = 0
    @Published var selectAlgorithm = "bubble"
    @Published var selectGraph = ".bar"
    @Published var myTitle: String = "bubbleSort()"
    @Published var graphMark: String = "|  .bar"
    @Published var bubbleSortPrompt: String = "Prompt"
   


    func mapSliderValueToDelayTime(_ sliderValue: Double) -> Double {
      let minDelay: Double = 1.0 // reset after 0.5 sec for sorting 0-20ms
      let maxDelay: Double = 4.0 // reset after 1 sec for sorting 20-60ms
      let minValue: Double = 00.0
      let maxValue: Double = 100.0
      
      if sliderValue <= minValue {
        return minDelay
      } else if sliderValue >= maxValue {
        return maxDelay
      } else {
        let delayRange = maxDelay - minDelay
        let valueRange = maxValue - minValue
        return (sliderValue - minValue) * delayRange / valueRange + minDelay
      }
    }
    
    
    func swapColors(value: Int) -> Color {
        if let swoop, value <= swoop {
            return cvm.purple
        }
        if value == activeValue {
            return cvm.purple
        } else if value == previousValue {
            return cvm.purple
        }
        return cvm.orange
    }
    
    
    func swapHelper(_ firstIndex: Int, _ secondIndex: Int) {
        let temp = data[secondIndex]
        data[secondIndex] = data[firstIndex]
        data[firstIndex] = temp
    }
    
    func bubbleSort() async throws {
        self.isSorting = true
        var isSorted = false
        var counter = 0
        
        
        while !isSorted {
            isSorted = true
            for i in 0 ..< data.count - 1 - counter {
                activeValue = data[i + 1]
                previousValue = data[i]
                if data[i] > data[i + 1] {
                    swapHelper(i, i + 1)
                    try await Task.sleep(until: .now.advanced(by: .milliseconds(sliderValue)), clock: .continuous)
                    isSorted = false
                    
                }
                
            }
            counter = counter + 1
            
   
            }
        let delayTime: Double = mapSliderValueToDelayTime(sliderValue)
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
          self.isSorting = false
        }
    }

    func insertionSort() async throws {
        self.isSorting = true
        
        for i in 1 ..< data.count {
            var j = i
            previousValue = data[i]
            activeValue = data[i - 1]
            while j > 0, data[j] < data[j - 1] {
                swapHelper(j, j - 1)
                try await Task.sleep(until: .now.advanced(by: .milliseconds(sliderValue)), clock: .continuous)
               
                j = j - 1
            }
        }
        let delayTime: Double = mapSliderValueToDelayTime(sliderValue)
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            self.isSorting = false
        }
    }
}

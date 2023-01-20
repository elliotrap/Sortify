import Foundation
import SwiftUI

class SortifyViewModel: ObservableObject {
    
    @ObservedObject var cvm = ColorViewModel()
    
    @Published var expand3 = false
    @Published var expand2 = false
    @Published var expand = false
    @Published var data = [Int]()
    @Published var data2 = [Int]()
    
    @Published var resetTime: Double = 0
    @Published var sliderValue: Double = 50
    @Published var isSorting = false
    @Published var activeValue = 0
    @Published var previousValue = 0
    @Published var swoop: Int?
    
    @Published var selectAlgorithm = "bubble"
    @Published var selectGraph = ".bar"
    @Published var  myTitle: String = "Bubble Sort"
    @Published var bubbleSortPrompt: String = "Prompt"
    
    


    
    
    
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
        
        func swapHelper(_ firstIndex: Int, _ secondIndex: Int) {
            let temp = data[secondIndex]
            data[secondIndex] = data[firstIndex]
            data[firstIndex] = temp
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(resetTime))) {
            self.isSorting = false
            }
    }
    
    // insertion sort
    func insertionSort() async throws {
        var isSorted = false
        var counter = 0
        
        
        while !isSorted {
            isSorted = true
            for i in 0 ..< data.count - 1 - counter {
                if data[i] > data[i + 1] {
                    swapHelper(i, i + 1)
                    try await Task.sleep(until: .now.advanced(by: .milliseconds(resetTime)), clock: .continuous)
                    isSorted = false
                    
                }
                
            }
            counter = counter + 1
        }
        
        func swapHelper(_ firstIndex: Int, _ secondIndex: Int) {
            let temp = data[secondIndex]
            data[secondIndex] = data[firstIndex]
            data[firstIndex] = temp
        }
    }
}

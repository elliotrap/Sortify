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
    @Published var slowSliderValue: Double = 0.5000000000
    
    @Published var isSorting = false
    @Published var pivot = 0
    @Published var activeValue = 0
    @Published var previousValue = 0
    @Published var swoop: Int?
    @Published var isSwooping = false
    
    @Published var animationAmount: CGFloat = 1
    @Published var toggleGraph = false
    @Published var showGraph = 0
    @Published var selectAlgorithm = "bubble"
    @Published var selectGraph = ".bar"
    @Published var myTitle: String = "bubbleSort()"
    @Published var graphMark: String = "|  .bar"
    @Published var bubbleSortPrompt: String = "Prompt"
    
    func swooping() async throws {
        
        if selectGraph == ".bar" || selectGraph == ".point" {
            isSwooping = true
            
            pivot = 0
            activeValue = 0
            previousValue = 0
            
            for index in  0..<data.count {
                swoop = data[index]
                try await Task.sleep(until: .now.advanced(by: .milliseconds(10)), clock: .continuous)
            }
            isSwooping = false
        } else if selectGraph == ".line" || selectGraph == ".area" {
            
            pivot = 0
            activeValue = 0
            previousValue = 0
            
            for index in  0..<data.count {
                swoop = data[index]
            }
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
        } else if value == pivot {
            return cvm.purple
        }
        return cvm.orange
    }
    
    func swapColorsTwo(valueTwo: Int) -> Color {
        if let swoop, valueTwo <= swoop {
            return cvm.purple
        }
        return cvm.orange
    }
    func swapHelper(_ firstIndex: Int, _ secondIndex: Int) {
        let temp = data[secondIndex]
        data[secondIndex] = data[firstIndex]
        data[firstIndex] = temp
    }
    
    func generateInput() -> [Int] {
        var array = [Int]()
        for i in 1...35{
            array.append(i)
        }
        return array.shuffled()
        
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
                    try await Task.sleep(until: .now.advanced(by: .milliseconds(sliderValue * 10)), clock: .continuous)
                    isSorted = false
                    
                }
                
            }
            counter = counter + 1
            
            
        }
        self.isSorting = false
    }
    
    func insertionSort() async throws   {
        self.isSorting = true
        
        for i in 1 ..< data.count {
            var j = i
            previousValue = data[i]
            activeValue = data[i - 1]
            while j > 0, data[j] < data[j - 1] {
                swapHelper(j, j - 1)
                try await Task.sleep(until: .now.advanced(by: .milliseconds(sliderValue * 10)), clock: .continuous)
                
                j = j - 1
            }
        }
        self.isSorting = false
        
    }
    
    func  quickSort() async throws {
        self.isSorting = true
        
        try await quickSortHelper(0, data.count - 1)
        
        self.isSorting = false
    }
    
    func quickSortHelper(_ startIndex: Int, _ endIndex: Int) async throws {
        
        if startIndex >= endIndex {
            return
        }
        
        let pivotIndex = startIndex
        var firstIndex = startIndex + 1
        var secondIndex = endIndex
        
        
        while firstIndex <= secondIndex {
            
            pivot = data[pivotIndex]
            previousValue = data[firstIndex]
            activeValue = data[secondIndex - 1]
            if data[firstIndex] > data[pivotIndex] && data[secondIndex] < data[pivotIndex] {
                try await Task.sleep(until: .now.advanced(by: .milliseconds (sliderValue * 10)), clock: .continuous)
                swapHelper(firstIndex, secondIndex)
            }
            if data[firstIndex] <= data[pivotIndex] {
                firstIndex += 1
            }
            if data[secondIndex] >= data[pivotIndex] {
                secondIndex -= 1
            }
        }
        swapHelper(pivotIndex, secondIndex)
        
        try await quickSortHelper(startIndex, secondIndex - 1)
        try await quickSortHelper(secondIndex + 1, endIndex)
        
        
        
        
    }
    
    
    func radixSort() async throws  {
        guard data.count > 1 else {
            return
        }
        
        let radix = 10
        var done = false
        var digits = 1
        
        var newArray = data
        
        while !done {
            done = true
            var buckets: [[Int]] = []
            
            for _ in 1...radix {
                buckets.append([])
            }
            
            for number in newArray {
                let remainingPart = number / digits
                let bucket = remainingPart % radix
                buckets[bucket].append(number)
                
                if done && bucket > 0 {
                    done = false
                }
            }
            
            digits *= radix
            newArray.removeAll()
            
            for bucket in buckets {
                for number in bucket {
                    newArray.append(number)
                    try await Task.sleep(until: .now.advanced(by: .milliseconds (sliderValue * 10)), clock: .continuous)

                }
            }
        }
    }
}


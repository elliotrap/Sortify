
import Foundation
import SwiftUI
import UIKit


class SortifyViewModel: ObservableObject {
    static var shared = SortifyViewModel()
    
    @ObservedObject var cvm = ColorViewModel()
    
    @Published var algoButtonPressed = false
    @Published var expand4 = false
    @Published var expand3 = false
    @Published var expand2 = false
    @Published var expand = false
    @Published var algorithmsButtonScrollHeight: CGFloat = 0
    @Published var algorithmsButtonHeight: CGFloat = 40
    @Published var graphsButtonHeight: CGFloat = 40
    @Published var nodesButtonHeight: CGFloat = 40
    
    @Published var data = [Int]()
    @Published var nodes = 35

    @Published var sliderValue: Double = 49.9999999999

    @Published var sortComplete = false
    @Published var isSorting = false
    @Published var pivot = 0
    @Published var activeValue = 0
    @Published var previousValue = 0
    @Published var swoop: Int?
    @Published var shuffle: Int?
    @Published var isSwooping = false
    

    @Published var toggleGraph = false
    @Published var showGraph = 0
    @Published var selectAlgorithm = "bubble"
    @Published var selectGraph = ".bar"
    @Published var myTitle: String = "bubbleSort()"
    @Published var graphMark: String = "bar:"
    @Published var nodeCount: String = "nodes:"
    @Published var whileCount: String = "while:"
    @Published var forCountCounter: Int = 0
    @Published var forCount: String = "for:"
    @Published var whileCountCounter: Int = 0

    func swooping() async throws {
        
        if selectGraph == ".bar" || selectGraph == ".point" {
            isSwooping = true
            
            
            pivot = 0
            activeValue = 0
            previousValue = 0
            
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator.prepare()
            
            for index in  0..<data.count {
                swoop = data[index]
                beep(index)

                feedbackGenerator.impactOccurred(intensity: 10)

                try await Task.sleep(until: .now.advanced(by: .milliseconds(1)), clock: .continuous)
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
    
    func generateInput() -> [Int]  {
        var array = [Int]()
        for i in 1...nodes {
            array.append(i)
        }

        return array.shuffled()
    }

    
    @MainActor
    func fisherYatesShuffle() async throws {
        swoop = 0
        forCountCounter = 0
        whileCountCounter = 0
        sortComplete = false
        // Initialize the haptic feedback generator
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
        feedbackGenerator.prepare()
        
        for i in (0..<data.count).reversed() {
            let j = Int(arc4random_uniform(UInt32(i + 1)))
            if i != j {
                feedbackGenerator.impactOccurred()
                beep(data[j + 1])
                activeValue = data[i]
                previousValue = data[j]
                try await Task.sleep(until: .now.advanced(by: .milliseconds(10)), clock: .continuous)
                data.swapAt(i, j)
                
            }
        }
        activeValue = 0
        previousValue = 0
    }

    @MainActor
    func bubbleSort() async throws {
        isSorting = true
        var isSorted = false
        var counter = 0
        
        // Initialize the haptic feedback generator
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
        feedbackGenerator.prepare()
        
        while !isSorted {
            whileCountCounter += 1
            isSorted = true
            for i in 0 ..< data.count - 1 - counter {
                forCountCounter += 1
                activeValue = data[i + 1]
                previousValue = data[i]
                if data[i] > data[i + 1] {
                    feedbackGenerator.impactOccurred(intensity: 1)
                    beep(data[i + 1])
                    swapHelper(i, i + 1)
                    try await Task.sleep(until: .now.advanced(by: .milliseconds(sliderValue * 10)), clock: .continuous)
                    isSorted = false
                    
                }
            }
            counter = counter + 1
        }
        isSorting = false
        sortComplete = true
    }
    
    func insertionSort() async throws   {
        isSorting = true
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred(intensity: 10)
        for i in 1 ..< data.count {
            forCountCounter += 1
            var j = i
            previousValue = data[i]
            activeValue = data[i - 1]
            while j > 0, data[j] < data[j - 1] {
                whileCountCounter += 1
                feedbackGenerator.impactOccurred(intensity: 10)
                beep(j - 1)
                swapHelper(j, j - 1)
                try await Task.sleep(until: .now.advanced(by: .milliseconds(sliderValue * 10)), clock: .continuous)
                
                j = j - 1
            }
        }
        isSorting = false
        sortComplete = true

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
        let notificationGenerator = UINotificationFeedbackGenerator()
        notificationGenerator.prepare()

        // Trigger vibration at the start of processing pivotIndex
        notificationGenerator.notificationOccurred(.warning)

        while firstIndex <= secondIndex {
            whileCountCounter += 1
            pivot = data[pivotIndex]
            previousValue = data[firstIndex]
            activeValue = data[secondIndex - 1]
            notificationGenerator.notificationOccurred(.warning)

            if data[firstIndex] > data[pivotIndex] && data[secondIndex] < data[pivotIndex] {
                try await Task.sleep(until: .now.advanced(by: .milliseconds(sliderValue * 10)), clock: .continuous)
                swapHelper(firstIndex, secondIndex)

                // Trigger vibration after swapping firstIndex and secondIndex
                notificationGenerator.notificationOccurred(.warning)
                beep(firstIndex)
                beep(secondIndex)
            }

            if data[firstIndex] <= data[pivotIndex] {
                firstIndex += 1
                // Vibration for firstIndex increment
                notificationGenerator.notificationOccurred(.warning)
                
            }

            if data[secondIndex] >= data[pivotIndex] {
                secondIndex -= 1
                // Vibration for secondIndex decrement
                notificationGenerator.notificationOccurred(.warning)
                
            }
        }

        // Trigger vibration after swapping the pivot index with secondIndex
        notificationGenerator.notificationOccurred(.warning)
        swapHelper(pivotIndex, secondIndex)
        beep(pivotIndex)
        beep(secondIndex)
        try await quickSortHelper(startIndex, secondIndex - 1)
        try await quickSortHelper(secondIndex + 1, endIndex)
        sortComplete = true
    }
    
    
    
    
        func getDigit(_ number: Int, at place: Int) -> Int {
            return (number / place) % 10
            
        }
        
        func countingSort(by place: Int) async throws {
            
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
            feedbackGenerator.prepare()
            let radix = 10
            var count = [Int](repeating: 0, count: radix)
            var output = [Int](repeating: 0, count: data.count)
            
            for number in data {
                forCountCounter += 1
                let digit = getDigit(number, at: place)
                count[digit] += 1
                activeValue = number
                beep(number)
                feedbackGenerator.impactOccurred(intensity: 1)

                try await Task.sleep(until: .now.advanced(by: .milliseconds(Int(sliderValue * 10))), clock: .continuous)

            }
            
            for i in 1..<radix {
                forCountCounter += 1
                count[i] += count[i - 1]
                activeValue = i
                beep(i)
                feedbackGenerator.impactOccurred(intensity: 1)
                try await Task.sleep(until: .now.advanced(by: .milliseconds(Int(sliderValue * 10))), clock: .continuous)
            }
            
            for number in data.reversed() {
                forCountCounter += 1
                let digit = getDigit(number, at: place)
                count[digit] -= 1
                output[count[digit]] = number
                activeValue = number
                previousValue = place
                beep(number)
                feedbackGenerator.impactOccurred(intensity: 1)
                try await Task.sleep(until: .now.advanced(by: .milliseconds(Int(sliderValue * 10))), clock: .continuous)
            }
            
            for i in 0..<data.count {
                forCountCounter += 1
                activeValue = i
                data[i] = output[i]
                beep(i)
                feedbackGenerator.impactOccurred(intensity: 1)
                try await Task.sleep(until: .now.advanced(by: .milliseconds(Int(sliderValue * 10))), clock: .continuous)
            }
        }
        
        func getMax() -> Int {
            guard let max = data.max() else {
                fatalError("Array is empty")
            }
            return max
        }
        
        func radixSort() async throws {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
            feedbackGenerator.prepare()
            isSorting = true
            let maxNumber = getMax()
            var place = 1
            
            while maxNumber / place > 0 {
                whileCountCounter += 1
                try await countingSort(by: place)
                place *= 10
            }
            
            isSorting = false
            sortComplete = true
        }
    
    
    
    @MainActor
    func bitonicMerge(low: Int, cnt: Int, dir: Bool) async throws {
        if cnt > 1 {
            let k = cnt / 2
            for i in low ..< low + k {
                forCountCounter += 1
                if (dir && data[i] > data[i + k]) || (!dir && data[i] < data[i + k]) {
                    // Haptic feedback and beep sound
                    let feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
                    feedbackGenerator.prepare()
                    beep(data[i + k])
                    activeValue = data[i + k]
                    previousValue = data[i]
                    feedbackGenerator.impactOccurred(intensity: 1)
                    swapHelper(i, i + k)
                    try await Task.sleep(until: .now.advanced(by: .milliseconds(sliderValue * 10)), clock: .continuous)
                }
            }
            try await bitonicMerge(low: low, cnt: k, dir: dir)
            try await bitonicMerge(low: low + k, cnt: k, dir: dir)
        }
    }

    @MainActor
    func bitonicSort(low: Int, cnt: Int, dir: Bool) async throws {
        if cnt > 1 {
            let k = cnt / 2
            try await bitonicSort(low: low, cnt: k, dir: true)
            try await bitonicSort(low: low + k, cnt: k, dir: false)
            try await bitonicMerge(low: low, cnt: cnt, dir: dir)
        }
        print("Sorted section (low: \(low), cnt: \(cnt), dir: \(dir)): \(data[low..<low+cnt])")
    }

    @MainActor
    func sort() async throws {
        isSorting = true
        print("Initial data: \(data)")
        let n = data.count
        
        // Find a suitable padding value
        let maxValue = (data.max() ?? 0) + 1
        let paddedCount = Int(pow(2.0, ceil(log2(Double(n)))))
        while data.count < paddedCount {
            whileCountCounter += 1
            data.append(maxValue)
        }
        
        try await bitonicSort(low: 0, cnt: paddedCount, dir: true)
        
        // Remove padding
        data = Array(data.prefix(n))
        print("Final sorted array: \(data)")
        isSorting = false
        sortComplete = true
    }

    func updateVisualization() {
        // Filter out the padding value from visualization updates
        let maxValue = (data.max() ?? 0) + 1
        let filteredData = data.filter { $0 != maxValue }
        // Update the bar graph with filteredData
        // ... (your visualization update logic here)
    }
    
        @MainActor
        func cocktailShakerSort() async throws {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
            feedbackGenerator.prepare()
            isSorting = true
            var swapped = true
            var start = 0
            var end = data.count - 1

            while swapped {
                swapped = false
                whileCountCounter += 1
                // Forward pass
                for i in start..<end {
                    if data[i] > data[i + 1] {
                        feedbackGenerator.impactOccurred(intensity: 1)
                        activeValue = data[i + 1]
                        previousValue = data[i]
                        beep(data[i - 1])

                        forCountCounter += 1
                        swapHelper(i, i + 1)
                        try await Task.sleep(until: .now.advanced(by: .milliseconds(Int(sliderValue) * 10)), clock: .continuous)

                        // Update the chart view
                        objectWillChange.send()
                        swapped = true
                    }
                }

                if !swapped {
                    break
                }

                swapped = false
                end -= 1

                // Backward pass
                for i in stride(from: end, to: start, by: -1) {
                    if data[i] < data[i - 1] {
                        feedbackGenerator.impactOccurred(intensity: 1)
                        activeValue = data[i - 1]
                        previousValue = data[i]
                        beep(data[i - 1])
                        forCountCounter += 1
                        // Swap elements
                        swapHelper(i, i - 1)
                        try await Task.sleep(until: .now.advanced(by: .milliseconds(Int(sliderValue) * 10)), clock: .continuous)

                        // Update the chart view
                        objectWillChange.send()
                        swapped = true
                    }
                }

                start += 1
            }

            isSorting = false
            sortComplete = true
        }
    


    

    

    
    
    
    



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


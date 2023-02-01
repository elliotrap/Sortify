//
//  ContentView.swift
//  Sortify
//
//  Created by Elliot Rapp on 1/18/23.
//

import SwiftUI
import Charts


struct ContentView : View {
   
    // Back-end view model
    @ObservedObject var vm = SortifyViewModel()
    
    @ObservedObject var textVm = TextViewModel()
    
    // color view model
    @ObservedObject var cvm = ColorViewModel()
    
    
    
    var body: some View {
        
        

        ScrollView {
            
            HStack {
                ZStack {
                    
                    
                    
                    
                    // graph background
                    RoundedRectangle(cornerRadius: 25)
                    
                        .foregroundColor(cvm.graphBackground)
                        .position(x: 175, y: 75)
                        .frame(width: 350, height: 630)
                    
                    // control pane for the buttons
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient (
                                
                                gradient: Gradient(colors: [cvm.controlBackgroundBlue, cvm.controlBackgroundBlack]),
                                startPoint: .top,
                                endPoint: .bottom)
                        )
                        .frame(width: 305, height: 200)
                        .position(x:250, y: 543)
                    
                    
                    
                    // demonstration display for space time complexity and pseudo code
                    RoundedRectangle(cornerRadius: 25)
                        
                        .foregroundColor(cvm.graphBackground)
                        .frame(width: 350, height: 400)
                        .position(x: 250, y: 930)
                    
                    ZStack {
                        
                        
                        
                        
                        // Algorithm title
                        Text(vm.myTitle)
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(cvm.orange)
                            .position(x: 210, y: 20)
                        
                        
                        // graph chosen
                        Text(vm.graphMark)
                            .font(.system(size: 12))
                            .foregroundColor(cvm.orange)
                            .position(x: 242, y: 431)
                        
                        // Algorithm title
                        Text(vm.myTitle)
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(cvm.orange)
                            .position(x: 210, y: 20)
                        
                        // Algorithm pseudo code
                        if vm.selectAlgorithm == "bubble" || vm.selectAlgorithm == "insertion" {
                            Text(textVm.pseudoCode)
                                .font(.system(size: 20))
                                .foregroundColor(Color.white)
                                .position(x: 195, y: 490)
                                .frame(width: 500, height: 310)
                            
                        } else if vm.selectAlgorithm == "quick" || vm.selectAlgorithm == "radix" {
                            Text(textVm.pseudoCode)
                                .font(.system(size: 14))
                                .foregroundColor(Color.white)
                                .position(x: 195, y: 490)
                                .frame(width: 500, height: 300)
                        }
                        
                    }
                   
        
                    
                    
                    ZStack {
                        
                        
                        // if else statement to choose between bar graph, point graph, line graph
                        if vm.selectGraph == ".bar" {
                            Chart {
                                ForEach(Array(zip(vm.data.indices, vm.data)), id: \.0)  {index, item in
                                    BarMark(x: .value("Position", index), y: .value("Value", item))
                                        .foregroundStyle(vm.swapColors(value: item)) // bar graph
                                    
                                }
                                
                            }
                        } else if vm.selectGraph == ".point" {
                            Chart {
                                ForEach(Array(zip(vm.data.indices, vm.data)), id: \.0)  {index, item in
                                    PointMark(x: .value("Position", index), y: .value("Value", item))
                                        .foregroundStyle(vm.swapColors(value: item)) // point graph
                                }
                                
                            }
                            
                        } else if vm.selectGraph == ".line" {
                            Chart {
                                ForEach(Array(zip(vm.data.indices, vm.data)), id: \.0)  {index, item in
                                    LineMark(x: .value("Position", index), y: .value("Value", item))
                                        .foregroundStyle(vm.swapColorsTwo(valueTwo: item)) // line graph
                                }
                                
                                
                            }
                        } else if vm.selectGraph == ".area" {
                            Chart {
                                ForEach(Array(zip(vm.data.indices, vm.data)), id: \.0)  {index, item in
                                    AreaMark(x: .value("Position", index), y: .value("Value", item))
                                        .foregroundStyle(vm.swapColorsTwo(valueTwo: item))// line graph
                                }
                            }
                        }
                        
                    }
                    
                    // chart y axis data marks
                    .chartYAxis{
                        AxisMarks {
                            mark in
                        }
                    }
                    
                    // chart x axis data marks
                    .chartXAxis{
                        AxisMarks {
                            mark in
                        }
                    }
                    .foregroundStyle(cvm.orange)
                    .position(x:208, y: -180)
                    .frame(width: 360, height: 400)
                    
                    ZStack {
                        // slider with milliseconds
                        Text("mill:")
                            .font(.system(size: 12))
                            .foregroundColor(cvm.orange)
                            .position(x:107, y:431)
                        
                            Text(
                                String(format:"%.10f", vm.sliderValue)
                            )
                            .font(.system(size: 12))
                            .foregroundColor(cvm.orange)
                            .position(x:170, y:431)
                
       
                        
                        
                            Slider(value: $vm.sliderValue, in: 0.9999999999...99.9999999999)
                            
                                .accentColor(cvm.purple)
                                .frame(width: 200, height: 10)
                                .position(x: 250, y: 600)

                        
                    }
                    
                                          
                    
                    VStack(alignment: .leading, content:  {
                        
                        // Algorithms buttons
                        HStack{
                            
                            Text("ALGORITHMS")
                            .font(.system(size: 12))
                            Image(systemName: "wand.and.stars").resizable().frame(width: 20, height: 20)
                        }.onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                vm.expand.toggle()
                            }
                            vm.algoButtonPressed.toggle()
                        }
                        .foregroundColor(vm.isSorting || vm.isSwooping ? Color.gray : Color.white)       .disabled(vm.isSorting || vm.isSwooping)


                        if vm.expand {
                            
                            // button that triggers bubble sort for the sort button
                            Button(action:  {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                    vm.expand.toggle()
                                }
                                vm.myTitle = "bubbleSort()"
                                vm.selectAlgorithm = "bubble"
                                vm.algoButtonPressed.toggle()
                                textVm.pseudoCode = """
                                
                        function bubble_sort()
                            isSorted = false
                            n = array
                            while not isSorted
                            isSorted = true
                            
                                for j in range(0, n-i-1):
                                if array[j] > array[j+1]:
                                    swap(i, i + 1)
                                    isSorted = false
                        
                        return array
"""
                            }) {
                                Text("bubble sort").padding()
                                    .underline(false)

                            }
                            
                            .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                            
                            // button that triggers selection sort for the sort button
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                    vm.expand.toggle()
                                }
                                vm.myTitle = "insertionSort()"
                                vm.selectAlgorithm = "insertion"
                                vm.algoButtonPressed.toggle()
                                textVm.pseudoCode = """
                        function insertion_sort(array):
                        for i in range(1, len(array)):
                            key = array[i]
                            j = i-1
                            
                        while j >= 0 and array[j] > key:
                                array[j + 1] = array[j]
                                j -= 1
                            array[j + 1] = key
                        
                        return array
"""


                            }) {
                                Text("insertion sort").padding()
                                    .underline(false)

                            }
                            .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                            
                            // button that triggers heap sort for the sort button
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                    vm.expand.toggle()
                                }
                                
                                vm.myTitle = "quickSort()"
                                vm.selectAlgorithm = "quick"
                                vm.algoButtonPressed.toggle()
                                textVm.pseudoCode = """
                            function quick_sort(arr, start, end):
                                if start < end:
                                    pivotIdx = partition(arr, start, end)
                                    quickSort(arr, start, pivotIdx - 1)
                                    quickSort(arr, pivotIdx + 1, end)

                            function partition(arr, start, end):
                                pivot = arr[end]
                                pivotIdx = start
                                for i in range(start, end):
                                    if arr[i] <= pivot:
                                        arr[i], arr[pivotIdx] = arr[pivotIdx], arr[i]
                                        pivot_index += 1
                                arr[end], arr[pivotIdx] = arr[pivotIdx], arr[end]
                               
                            return pivotIdx
"""

                            }) {
                                Text("quick sort").padding()
                                    .underline(false)

                            } .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                    vm.expand.toggle()
                                }
                                
                                vm.myTitle = "radixSort()"
                                vm.selectAlgorithm = "radix"
                                vm.algoButtonPressed.toggle()
                                textVm.pseudoCode = """
                            function radixSort(array, radix=10):
                                max_val = max(array)
                                max_digits = len(str(max_val))
                                for i in range(max_digits):
                                    buckets = [[] for x in range(radix)]
                                    
                                    for num in array:
                                        digit = (num // (radix ** i)) % radix
                                        buckets[digit].append(num)
                                    
                                array = []
                                for sublist in buckets:
                                    array.extend(sublist)
                                
                            return array
"""

                            }) {
                                Text("radix sort").padding()
                                    .underline(false)

                            } .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                        }
                    })
                    
                    .frame(height: vm.expand ? 280 : 8)
                    .padding()
                    .background(cvm.purple)
                    .cornerRadius(20)
                    .position(x: 323, y: 480)
                    
                    // buttons to choose between bar, point, and line graph.
                    
                    if vm.algoButtonPressed == false {
                        
                        VStack(alignment: .leading, content:  {
                            
                            
                            HStack {
                                
                                // graph button title
                                Text("    GRAPHS    ")
                                    .font(.system(size: 12))
                                
                                Image(systemName: "chart.bar.fill").resizable().frame(width: 20, height: 20)
                            }.onTapGesture {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                    vm.expand2.toggle()
                                }
                            }
                            .foregroundColor(vm.isSorting || vm.isSwooping ? Color.gray : Color.white) .disabled(vm.isSorting || vm.isSwooping)

                            
                            
                            if vm.expand2 {
                                
                                // button for bar graph
                                Button(action:  {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                        vm.expand2.toggle()
                                    }
                                    
                                    vm.graphMark = "|  .bar"
                                    vm.selectGraph = ".bar"
                                    
                                    
                                })
                                {
                                    Text("bar graph").padding()
                                        .underline(false)
                                    
                                }
                                .buttonStyle(.borderless)
                                .foregroundColor(Color.white)
                                
                                // button for point graph
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                        vm.expand2.toggle()
                                    }
                                    vm.graphMark = "    |  .point"
                                    vm.selectGraph = ".point"
                                    
                                    
                                }) {
                                    Text("point graph").padding()
                                        .underline(false)
                                    
                                }
                                .buttonStyle(.borderless)
                                .foregroundColor(Color.white)
                                
                                // button for line graph
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                        vm.expand2.toggle()
                                    }
                                    
                                    vm.graphMark = "|  .line"
                                    vm.selectGraph = ".line"
                                    
                                    
                                }) {
                                    Text("line graph").padding()
                                        .underline(false)
                                    
                                }
                                .buttonStyle(.borderless)
                                .foregroundColor(Color.white)
                                
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                        vm.expand2.toggle()
                                    }
                                    
                                    vm.graphMark = "|  .area"
                                    vm.selectGraph = ".area"
                                    
                                    
                                }) {
                                    Text("area graph").padding()
                                        .underline(false)
                                    
                                }
                                .buttonStyle(.borderless)
                                .foregroundColor(Color.white)
                            }
                        })
                        
                        .frame(height: vm.expand2 ? 280 : 8)
                        .padding()
                        .background(cvm.purple)
                        .cornerRadius(20)
                        .position(x: 323, y: 540)
                    }
                    ZStack {
                        
                        // SORT button
                        Button {
                            
                            Task {
                                
                                // if else statement that run an algorithm based on what the selectAlgorithm is
                                if vm.selectAlgorithm == "bubble" {
                                    
                                    try await vm.bubbleSort()
                                    try await vm.swooping()
                                    
                                } else if vm.selectAlgorithm == "insertion" {
                                    
                                    try await vm.insertionSort()
                                    try await vm.swooping()
                                    
                                } else if vm.selectAlgorithm == "quick" {
                                    
                                    try await vm.quickSort()
                                    try await vm.swooping()
                                    
                                } else if vm.selectAlgorithm == "radix" {
                                    
                                    try await vm.radixSort()
                                    try await vm.swooping()
                                }
                            }
                        }
                    label: {
                        Text("SORT     ")
                            .font(.system(size: 12))
                            .underline(false)
                        Image(systemName: "play.fill")
                            .resizable().frame(width: 15, height: 15)
                    }
                        
                    .disabled(vm.isSorting || vm.isSwooping)
                        
                    .frame(width: 130, height: 37)
                    .foregroundColor(vm.isSorting || vm.isSwooping ? Color.gray : Color.white)
                    .buttonStyle(.borderless)
                    .background(cvm.purple)
                    .cornerRadius(20)
                    .position(x: 175, y: 480)
                        
                        // reset button that shuffles the data variable
                        Button {
                            
                            
                            Task {
                                vm.data.shuffle()
                                vm.swoop = 0
                                
                            }
                        }
                        
                    label: {
                        Text("RESET   ")
                            .font(.system(size: 12))
                            .underline(false)
                        
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .resizable().frame(width: 20, height: 20)
                    }
                        
                    .disabled(vm.isSorting || vm.isSwooping)
                    .frame(width: 130, height: 38)
                    .foregroundColor(vm.isSorting || vm.isSwooping ? Color.gray : Color.white)        .buttonStyle(.borderless)
                    .background(cvm.purple)
                    .cornerRadius(20)
                    .position(x: 175, y: 540)
                        
                        
                        // button for that displays different space time complexity's based on the algorithm chosen
                        
                        if vm.selectAlgorithm == "bubble" || vm.selectAlgorithm == "insertion" {
                            
                            
                            Button {
                                
                                withAnimation(Animation.spring()) {
                                    vm.expand3.toggle()
                                    vm.showGraph = 1
                                    vm.toggleGraph.toggle()
                                }
                                
                            }
                            
                        label: {
                            
                            Text("(AVRAGE CASE)")
                                .font(.system(size: 7))
                                .frame(width: 100.0, height: 20.0)
                                .position(x: 136, y: 8)
                                .underline(false)
                            
                            Text("O(n^2) Time | O(1) Space")
                                .font(.system(size: 17))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: 100, y: 23)
                                .underline(false)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 50, height: 4)
                                .foregroundColor(cvm.blurredPurple)
                                .position(x: vm.expand3 ? 65 : 65, y: vm.expand3 ? 290 : 39 )
                            Rectangle()
                                .frame(width: 3, height: 200)
                                .foregroundColor(Color.white)
                                .position(x: -100, y: 170)
                            Text("TIME")
                                .underline(false)
                                .font(.system(size: 10))
                                .rotationEffect(.degrees(270))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -150, y: 85)
                            Rectangle()
                                .frame(width: 238, height: 3)
                                .foregroundColor(Color.white)
                                .position(x: -64, y: 270)
                            ZStack {
                                Text("SPACE")
                                    .underline(false)
                                    .font(.system(size: 10))
                                    .frame(width: 300.0, height: 20.0)
                                    .position(x: -5, y: 280)
                                Rectangle()
                                    .frame(width: 238, height: 1)
                                    .foregroundColor(Color.white)
                                    .position(x: -105, y: 260)
                                Text("O(1)")
                                    .underline(false)
                                    .font(.system(size: 12))
                                    .frame(width: 300.0, height: 20.0)
                                    .position(x: -100, y: 245)
                                Ellipse()
                                    .trim(from: 0.7, to: 1.0)
                                    .stroke(lineWidth: 1)
                                    .rotationEffect(.degrees(100))
                                    .frame(width: 305, height: 140)
                                    .foregroundColor(Color.white)
                                    .position(x: -195, y: 109)
                                Text("O(n^2)")
                                    .underline(false)
                                    .font(.system(size: 12))
                                    .frame(width: 300.0, height: 20.0)
                                    .position(x: -170, y: 160)
                            }
                            
                        }
                            
                            
                        .frame(width: 280)
                        .frame(height: vm.expand3 ? 300 : 45)
                        .foregroundColor(Color.white)
                        .buttonStyle(.borderless)
                        .background(cvm.purple)
                        .cornerRadius(20)
                        .position(x: 250, y: 775)
                        } else if vm.selectAlgorithm == "quick" { Button {
                            
                            withAnimation(Animation.spring()) {
                                vm.expand3.toggle()
                                vm.showGraph = 1
                                vm.toggleGraph.toggle()
                            }
                            
                        }
                            
                        label: {
                            Text("O(nlog(n)) Time | O(1) Space")
                                .font(.system(size: 17))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: 136, y: 20)
                                .underline(false)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 50, height: 2)
                                .foregroundColor(cvm.blurredPurple)
                                .position(x: vm.expand3 ? 115 : 115, y: vm.expand3 ? 290 : 39 )
                            Rectangle()
                                .frame(width: 3, height: 200)
                                .foregroundColor(Color.white)
                                .position(x: -30, y: 170)
                            Text("TIME")
                                .underline(false)
                                .font(.system(size: 10))
                                .rotationEffect(.degrees(270))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -70, y: 85)
                            Rectangle()
                                .frame(width: 238, height: 3)
                                .foregroundColor(Color.white)
                                .position(x: 30, y: 270)
                            Text("SPACE")
                                .underline(false)
                                .font(.system(size: 10))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: 95, y: 280)
                            Rectangle()
                                .frame(width: 238, height: 1)
                                .foregroundColor(Color.white)
                                .position(x: -28, y: 260)
                            Text("O(1)")
                                .underline(false)
                                .font(.system(size: 12))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -45, y: 250)
                            Rectangle()
                                .rotationEffect(.degrees(145))
                                .frame(width: 270, height: 1)
                                .foregroundColor(Color.white)
                                .position(x: -94, y: 182)
                            Text("O(nlog(n))")
                                .underline(false)
                                .font(.system(size: 12))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -170, y: 160)
                            
                        }
                        .frame(width: 280)
                        .frame(height: vm.expand3 ? 300 : 45)
                        .foregroundColor(Color.white)
                        .buttonStyle(.borderless)
                        .background(cvm.purple)
                        .cornerRadius(20)
                        .position(x: 250, y: 775)
                            
                        } else if vm.selectAlgorithm == "quick" { Button {
                            
                            withAnimation(Animation.spring()) {
                                vm.expand3.toggle()
                                vm.showGraph = 1
                                vm.toggleGraph.toggle()
                            }
                            
                        }
                            
                        label: {
                            Text("O(nlog(n)) Time | O(1) Space")
                                .font(.system(size: 17))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: 136, y: 20)
                                .underline(false)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 50, height: 2)
                                .foregroundColor(cvm.blurredPurple)
                                .position(x: vm.expand3 ? 115 : 115, y: vm.expand3 ? 290 : 39 )
                            Rectangle()
                                .frame(width: 3, height: 200)
                                .foregroundColor(Color.white)
                                .position(x: -30, y: 170)
                            Text("TIME")
                                .underline(false)
                                .font(.system(size: 10))
                                .rotationEffect(.degrees(270))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -70, y: 85)
                            Rectangle()
                                .frame(width: 238, height: 3)
                                .foregroundColor(Color.white)
                                .position(x: 30, y: 270)
                            Text("SPACE")
                                .underline(false)
                                .font(.system(size: 10))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: 95, y: 280)
                            Rectangle()
                                .frame(width: 238, height: 1)
                                .foregroundColor(Color.white)
                                .position(x: -28, y: 260)
                            Text("O(1)")
                                .underline(false)
                                .font(.system(size: 12))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -45, y: 250)
                            Rectangle()
                                .rotationEffect(.degrees(145))
                                .frame(width: 270, height: 1)
                                .foregroundColor(Color.white)
                                .position(x: -94, y: 182)
                            Text("O(nlog(n))")
                                .underline(false)
                                .font(.system(size: 12))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -170, y: 160)
                            
                        }
                        .frame(width: 280)
                        .frame(height: vm.expand3 ? 300 : 45)
                        .foregroundColor(Color.white)
                        .buttonStyle(.borderless)
                        .background(cvm.purple)
                        .cornerRadius(20)
                        .position(x: 250, y: 775)
                        }   else if vm.selectAlgorithm == "radix" { Button {
                            
                            withAnimation(Animation.spring()) {
                                vm.expand3.toggle()
                                vm.showGraph = 1
                                vm.toggleGraph.toggle()
                            }
                            
                        }
                            
                        label: {
                            Text("O(d * (n + b)) Time | O(n + b) Space")
                                .font(.system(size: 14))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: 136, y: 20)
                                .underline(false)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 50, height: 2)
                                .foregroundColor(cvm.blurredPurple)
                                .position(x: vm.expand3 ? 115 : 115, y: vm.expand3 ? 290 : 39 )
                            Rectangle()
                                .frame(width: 3, height: 200)
                                .foregroundColor(Color.white)
                                .position(x: -30, y: 170)
                            Text("TIME")
                                .underline(false)
                                .font(.system(size: 10))
                                .rotationEffect(.degrees(270))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -70, y: 85)
                            Rectangle()
                                .frame(width: 238, height: 3)
                                .foregroundColor(Color.white)
                                .position(x: 30, y: 270)
                            Text("SPACE")
                                .underline(false)
                                .font(.system(size: 10))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: 95, y: 280)
                            Rectangle()
                                .frame(width: 238, height: 1)
                                .foregroundColor(Color.white)
                                .position(x: -28, y: 260)
                            Text("O(1)")
                                .underline(false)
                                .font(.system(size: 12))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -45, y: 250)
                            Rectangle()
                                .rotationEffect(.degrees(145))
                                .frame(width: 270, height: 1)
                                .foregroundColor(Color.white)
                                .position(x: -94, y: 182)
                            Text("O(nlog(n))")
                                .underline(false)
                                .font(.system(size: 12))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -170, y: 160)
                            
                        }
                        .frame(width: 280)
                        .frame(height: vm.expand3 ? 300 : 45)
                        .foregroundColor(Color.white)
                        .buttonStyle(.borderless)
                        .background(cvm.purple)
                        .cornerRadius(20)
                        .position(x: 250, y: 775)
                            
                        }
                    }
                    
     
            }
            // length of the scroll view
            .frame(maxHeight: .infinity)
        }
        .frame(minWidth: 430, maxWidth: 430, minHeight: 1200, maxHeight: 1200)
    }

        .background(LinearGradient (
            
            gradient: Gradient(colors: [cvm.blue, cvm.black]),
            startPoint: .top,
            endPoint: .bottom)
    )

            
            
            .onAppear {
                vm.data = vm.generateInput()
            }
    }

    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            
            ContentView()
        }
        
    }

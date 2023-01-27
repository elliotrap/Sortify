//
//  ContentView.swift
//  Sortify
//
//  Created by Elliot Rapp on 1/18/23.
//

import SwiftUI
import Charts


struct ContentView : View {
    var input: [Int] {
        var array = [Int]()
        for i in 1...35{
            array.append(i)
        }
        return array.shuffled()
    }
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
                        .position(x: 175, y: -40)
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
                        .position(x:215, y: 560)
                    
                    
                    
                    // demonstration display for space time complexity and pseudo code
                    RoundedRectangle(cornerRadius: 25)
                        
                        .foregroundColor(cvm.graphBackground)
                        .frame(width: 350, height: 740)
                        .position(x: 215, y: 1090)
                    
                    ZStack {
                        
                        // pseudo code background
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                LinearGradient (
                                    
                                    gradient: Gradient(colors: [cvm.controlBackgroundBlue, cvm.controlBackgroundBlack]),
                                    startPoint: .top,
                                    endPoint: .bottom)
                            )
                            .frame(width: 305, height: 350)
                            .position(x:215, y: 930)
                        
                        
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
                            .position(x: 212, y: 440)
                        
                        // Algorithm title
                        Text(vm.myTitle)
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(cvm.orange)
                            .position(x: 210, y: 20)
                        
                        // Algorithm pseudo code
                        Text(textVm.pseudoCode)
                            .font(.system(size: 17))
                            .foregroundColor(Color.white)
                            .position(x: 130, y: 480)
                            .frame(width: 250, height: 500)
                        
                        // Algorithm description
                        Text(textVm.prompt)
                            .font(.system(size: 17))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .position(x: 150, y: 900)
                            .frame(width: 300, height: 500)
                    
                        
                        
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
                                        .foregroundStyle(cvm.orange) // line graph
                                }
                                
                                
                            }
                        } else if vm.selectGraph == ".area" {
                            Chart {
                                ForEach(Array(zip(vm.data.indices, vm.data)), id: \.0)  {index, item in
                                    AreaMark(x: .value("Position", index), y: .value("Value", item))
                                        .foregroundStyle(cvm.orange) // line graph
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
                    .position(x:208, y: -300)
                    .frame(width: 360, height: 400)
                    
                    ZStack {
                        // slider with milliseconds
                        Text("mill:")
                            .font(.system(size: 12))
                            .foregroundColor(cvm.orange)
                            .position(x:75, y:440)
                        Text(
                            String(format:"%.10f", vm.sliderValue)
                        )
                        .font(.system(size: 12))
                        .foregroundColor(cvm.orange)
                        .position(x:140, y:440)
                        Slider(value: $vm.sliderValue, in: 0.9999999999...99.9999999999)
                        
                            .accentColor(cvm.purple)
                            .frame(width: 200, height: 10)
                            .position(x: 215, y: 620)
                        
                        
                        
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
                        .foregroundColor(vm.isSorting ? Color.gray : Color.white)
                        .disabled(vm.isSorting)

                        if vm.expand {
                            
                            // button that triggers bubble sort for the sort button
                            Button(action:  {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                        vm.expand.toggle()
                                    }
                                vm.myTitle = "bubbleSort()"
                                vm.selectAlgorithm = "bubble"
                                vm.algoButtonPressed.toggle()
                                textVm.prompt = " "
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
                                textVm.prompt = """
 Insertion sort is an algorithm that applies a sorted sub list to an existing unsorted list. This method of sorting takes the first element outside the sorted list; then the algorithm compares the value to all the elements in the sorted list, until it doesn't find an element that is greater than the value that is being compared against.

 The time complexity for this algorithm is O(n^2) in the average/worst case, but in the best case can be O(n) if the values are already sorted. The algorithm has to compare every value against the vale that is being swapped -- which gives you O(n^2). Nothing is being stored in memory, so the space complexity is O(1) space.
 
 Insertion sort isn't the most efficient, although its good for small data sets. Also its worth mentioning that the logic for this algorithm is quite small so its good if you need to whip up a quick sorting algorithm.
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
                                
                                vm.myTitle = "heapSort()"
                                vm.selectAlgorithm = "heap"
                                vm.algoButtonPressed.toggle()


                            }) {
                                Text("heap sort").padding()
                                    .underline(false)

                            } .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                        }
                    })
                    
                    .frame(height: vm.expand ? 350 : 8)
                    .padding()
                    .background(cvm.purple)
                    .cornerRadius(20)
                    .position(x: 285, y: 500)
                    
                    // buttons to choose between bar, point, and line graph.
                    
                    if vm.algoButtonPressed == false {
                        
                        VStack(alignment: .leading, content:  {
                            
                            
                            HStack {
                                
                                // graph button title
                                Text("   GRAPHS   ")
                                    .font(.system(size: 12))
                                
                                Image(systemName: "chart.bar.fill").resizable().frame(width: 20, height: 20)
                            }.onTapGesture {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                    vm.expand2.toggle()
                                }
                            }
                            .foregroundColor(vm.isSorting ? Color.gray : Color.white)
                            .disabled(vm.isSorting)
                            
                            
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
                        
                        .frame(height: vm.expand2 ? 300 : 8)
                        .padding()
                        .background(cvm.purple)
                        .cornerRadius(20)
                        .position(x: 285, y: 560)
                    }
                    ZStack {
                        
                        // SORT button
                        Button {
                            
                            Task {
                                
                                // if else statement that run an algorithm based on what the selectAlgorithm is
                                if vm.selectAlgorithm == "bubble" {
                                    
                                    try await vm.bubbleSort()
                                    
                                    
                                    
                                    if vm.selectGraph != ".area" {
                                        vm.activeValue = 0
                                        vm.previousValue = 0
                                        for index in  0..<vm.data.count {
                                            vm.swoop = vm.data[index]
                                            try await Task.sleep(until: .now.advanced(by: .milliseconds(vm.sliderValue)), clock: .continuous)
                                        }
                                
                                    }
                                } else if vm.selectAlgorithm == "insertion" {
                                    
                                    try await vm.insertionSort()
                                    vm.activeValue = 0
                                    vm.previousValue = 0
                                    
                                    for index in  0..<vm.data.count {
                                        vm.swoop = vm.data[index]
                                        try await Task.sleep(until: .now.advanced(by: .milliseconds(vm.sliderValue)), clock: .continuous)
                                    }
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
                        
                    .disabled(vm.isSorting)
                    .frame(width: 120, height: 37)
                    .foregroundColor(vm.isSorting ? Color.gray : Color.white)
                    .buttonStyle(.borderless)
                    .background(cvm.purple)
                    .cornerRadius(20)
                    .position(x: 140, y: 500)
                        
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
                        
                    .disabled(vm.isSorting)
                    .frame(width: 120, height: 37)
                    .foregroundColor(vm.isSorting ? Color.gray : Color.white)
                    .buttonStyle(.borderless)
                    .background(cvm.purple)
                    .cornerRadius(20)
                    .position(x: 140, y: 560)
                        
                        
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
                        .position(x: 215, y: 800)
                        } else if vm.selectAlgorithm == "heap" { Button {
                            
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
                                .position(x: 215, y: 800)
                            
                        }
                    }
                    
     
            }
            // length of the scroll view
            .frame(maxHeight: .infinity)
        }
        .frame(minWidth: 430, maxWidth: 430, minHeight: 1450, maxHeight: 1450)
    }

        .background(LinearGradient (
            
            gradient: Gradient(colors: [cvm.blue, cvm.black]),
            startPoint: .top,
            endPoint: .bottom)
    )

            
            
            .onAppear {
                vm.data = input
            }
    }

    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            
            ContentView()
        }
        
    }

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
    
    @ObservedObject var vm = SortifyViewModel()

    @ObservedObject var cvm = ColorViewModel()
    

    
    var body: some View {

        ScrollView(.vertical) {

                HStack {
                    ZStack {
                        
                        
                        
                        
                        // graph background
                        RoundedRectangle(cornerRadius: 25)
                        
                            .foregroundColor(cvm.graphBackground)
                            .position(x: 175, y: 170)
                            .frame(width: 350, height: 730)
                        
                        // controll pane
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                LinearGradient (
                                    
                                    gradient: Gradient(colors: [cvm.controlBackgroundBlue, cvm.controlBackgroundBlack]),
                                    startPoint: .top,
                                    endPoint: .bottom)
                            )
                            .frame(width: 305, height: 250)
                            .position(x:195, y: 580)
                        
                        
                        
                        // demonstration display
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                LinearGradient (
                                    
                                    gradient: Gradient(colors: [cvm.controlBackgroundBlack, cvm.controlBackgroundBlack]),
                                    startPoint: .top,
                                    endPoint: .bottom)
                            )
                        
                            .frame(width: 350, height: 400)
                            .position(x: 200, y: 1020)
                        
                        ZStack {
                            
                            // pseudo code background
                            RoundedRectangle(cornerRadius: 25)
                                .fill(
                                    LinearGradient (
                                        
                                        gradient: Gradient(colors: [cvm.controlBackgroundBlue, cvm.controlBackgroundBlack]),
                                        startPoint: .top,
                                        endPoint: .bottom)
                                )
                                .frame(width: 305, height: 550)
                                .position(x:200, y: 1110)
                            
                            // milliseconds background
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(cvm.purple)
                                .frame(width: 120, height: 50)
                                .position(x: 200, y: 622)
                            
                            // Algorithm title
                            Text(vm.myTitle)
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(cvm.orange)
                                .position(x: 200, y: 20)
                            
                        }
                        
                        ZStack {
                            
                            if vm.selectGraph == ".bar" {
                                Chart {
                                    ForEach(Array(zip(vm.data.indices, vm.data)), id: \.0)  {index, item in
                                        BarMark(x: .value("Position", index), y: .value("Value", item))
                                            .foregroundStyle(vm.swapColors(value: item))
                                        
                                    }
                                    
                                }
                            } else if vm.selectGraph == ".point" {
                                Chart {
                                    ForEach(Array(zip(vm.data.indices, vm.data)), id: \.0)  {index, item in
                                        PointMark(x: .value("Position", index), y: .value("Value", item))
                                            .foregroundStyle(vm.swapColors(value: item))
                                    }
                                    
                                }
                                
                            } else if vm.selectGraph == ".line" {
                                Chart {
                                    ForEach(Array(zip(vm.data.indices, vm.data)), id: \.0)  {index, item in
                                        LineMark(x: .value("Position", index), y: .value("Value", item))
                                            .foregroundStyle(vm.swapColors(value: item))
                                    }
                                    
                                    
                                }
                            }
                            
                        }
                        .chartYAxis{
                            AxisMarks {
                                mark in
                            }
                        }
                        
                        .chartXAxis{
                            AxisMarks {
                                mark in
                            }
                        }
                        .foregroundStyle(cvm.orange)
                        .position(x:205, y: -190)
                        .frame(width: 360, height: 400)
                        
                        ZStack {
                            
                            Text("milliseconds:")
                                .foregroundColor(.white)
                                .position(x:200, y:610)
                            Text(
                                String(format:"%.2f", vm.sliderValue)
                            )
                            .foregroundColor(.white)
                            .position(x:200, y:635)
                            Slider(value: $vm.sliderValue, in: 1...100)
                            
                                .accentColor(cvm.purple)
                                .frame(width: 200, height: 10)
                                .position(x: 200, y: 670)
                            
                            
                            
                        }
                        
                        //                        if vm.sliderValue >= 0.00 && vm.sliderValue <= 20.00 {
                        //                            vm.resetTime = 10.50
                        //                        } else if vm.sliderValue >= 20.00 && vm.sliderValue <= 50.00 {
                        //                            vm.resetTime = 1
                        //                        }
                        
                        VStack(alignment: .leading, content:  {
                            
                            // Algorithms buttons
                            HStack{
                                
                                Text("Algorithms")
                                
                                Image(systemName: "chevron.up.chevron.down").resizable().frame(width: 10, height: 10)
                            }.onTapGesture {
                                vm.expand.toggle()
                            }
                            .foregroundColor(Color.white)
                            
                            if vm.expand {
                                Button(action:  {
                                    vm.myTitle = "BubbleSort"
                                    vm.selectAlgorithm = "bubble"
                                    
                                }) {
                                    Text("bubble sort").padding()
                                }.foregroundColor(Color.white)
                                Button(action: {
                                    
                                    vm.myTitle = "Insertion Sort"
                                    vm.selectAlgorithm = "selection"
                                }) {
                                    Text("insertion sort").padding()
                                }.foregroundColor(Color.white)
                                Button(action: {
                                    
                                    vm.myTitle = "Heap Sort"
                                    vm.selectAlgorithm = "heap"
                                }) {
                                    Text("heap sort").padding()
                                }.foregroundColor(Color.white)
                            }
                        })
                        
                        .frame(height: vm.expand ? 200 : 8)
                        
                        .padding()
                        
                        .background(cvm.purple)
                        .cornerRadius(20)
                        .position(x: 270, y: 500)
                        
                        // graphs button
                        VStack(alignment: .leading, content:  {
                            
                            
                            HStack {
                                
                                Text("Graphs     ")
                                
                                Image(systemName: "chevron.up.chevron.down").resizable().frame(width: 10, height: 10)
                            }.onTapGesture {
                                vm.expand2.toggle()
                            }
                            .foregroundColor(Color.white)
                            
                            if vm.expand2 {
                                Button(action: {
                                    
                                    vm.selectGraph = ".bar"
                                    
                                    
                                }) {
                                    Text("Bar graph").padding()
                                }.foregroundColor(Color.white)
                                Button(action: {
                                    
                                    vm.selectGraph = ".point"
                                    
                                }) {
                                    Text("Point graph").padding()
                                }.foregroundColor(Color.white)
                                Button(action: {
                                    
                                    vm.selectGraph = ".line"
                                    
                                }) {
                                    Text("Line graph").padding()
                                }.foregroundColor(Color.white)
                            }
                        })
                        
                        .frame(height: vm.expand2 ? 200 : 8)
                        
                        .padding()
                        
                        .background(cvm.purple)
                        .cornerRadius(20)
                        .position(x: 270, y: 560)
                        
                        
                        
                        
                        
                        
                        
                        ZStack {
                            
                            // SORT button
                            Button {
                                
                                
                                Task {
                                    if vm.selectAlgorithm == "bubble" {
                                        try await vm.bubbleSort()
                                        vm.activeValue = 0
                                        vm.previousValue = 0
                                        
                                        for index in  0..<vm.data.count {
                                            vm.swoop = vm.data[index]
                                            
                                            try await Task.sleep(until: .now.advanced(by: .milliseconds(vm.sliderValue)), clock: .continuous)
                                        }
                                        
                                    } else if vm.selectAlgorithm == "selection" {
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
                            Text("SORT")
                            
                            Image(systemName: "chart.bar.fill")
                            
                        }
                            
                        .frame(width: 110, height: 37)
                        .foregroundColor(Color.white)
                        .background(cvm.purple)
                        .cornerRadius(20)
                        .position(x: 120, y: 500)
                            
                            // reset button
                            Button {
                                
                                
                                Task {
                                    vm.data.shuffle()
                                    vm.swoop = 0
                                    
                                }
                            }
                            
                        label: {
                            Text("Reset")
                            
                            Image(systemName: "arrow.triangle.2.circlepath")
                            
                        }
                            
                        .disabled(vm.isSorting)
                        .frame(width: 110, height: 37)
                        .foregroundColor(Color.white)
                        .background(cvm.purple)
                        .cornerRadius(20)
                        .position(x: 120, y: 560)
                            
                            
                            
                            Button {
                                
                                vm.expand3.toggle()
                                
                                
                            }
                            
                        label: {
                            Text("O(n^2) Time | O(1) Space")
                            Image(systemName: "chevron.down")
                            
                            
                        }
                            
                        .frame(width: 300)
                        .frame(height: vm.expand3 ? 300 : 40)
                        .foregroundColor(Color.white)
                        .background(cvm.purple)
                        .cornerRadius(20)
                        .position(x: 200, y: 870)
                            
                        }
                    
                        
                        
                        
                    }
                    .frame(maxHeight: .infinity)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 1230, maxHeight: 0)
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

//
//  ContentView.swift
//  Sortify
//
//  Created by Elliot Rapp on 1/18/23.
//
import Foundation
import SwiftUI
import Charts
import UIKit


struct ContentView : View {
   
    // Back-end view model
    @ObservedObject var vm = SortifyViewModel.shared
    
    @ObservedObject var textVm = TextViewModel.shared
    
    // color view model
    @ObservedObject var cvm = ColorViewModel()
    
    

    init() {
        for familyName in UIFont.familyNames {
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("-- \(fontName)")
            }
        }
      
    }
    
    
    var body: some View {
        
    

        ScrollView(showsIndicators: false) {
            
            
            
          
            // Algorithm title
            Text(vm.myTitle)
                .fontWeight(.heavy)
                .font(.custom("SourceCodePro-ExtraBold", size: 25))
                .foregroundColor(cvm.orange)
            
            // graph background
            
            
      
                    
          
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient (

                            gradient: Gradient(colors: [cvm.graphBackground, cvm.graphBackgroundBottom]),
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                .foregroundColor(cvm.graphBackground)
                    .frame(width: 350, height: 665)

                // Main Chart View
                VStack {
                    ChartView()
                        .frame(width: 350, height: 405)
                    ZStack {
                        VStack {
                        
                            Rectangle()
                                .stroke(lineWidth: 1)
                                .frame(width: 300, height: 17)


                                .foregroundColor(cvm.orange)
                            Spacer()
                                .frame(height: 1)
                        }
                        HStack(spacing: 8) {
                            Text("mill:")
                                .font(.custom("digital-7", size: 15))

                                .foregroundColor(cvm.orange)

                            
                            Text(
                                String(format:"%.6f", vm.sliderValue)
                                
                            )
                            .font(.custom("digital-7", size: 15))
                            .foregroundColor(cvm.orange)
                            
                            Rectangle()
                                .frame(width: 1, height: 17)
                                .foregroundColor(cvm.orange)

                            
                            if vm.selectGraph == ".bar" ||
                                vm.selectGraph == ".line" ||
                                vm.selectGraph == ".area" {
                                Text(vm.graphMark)
                                    .font(.custom("digital-7", size: 15))
                                    .foregroundColor(cvm.orange)
                            } else if vm.selectGraph == ".point" {
                                Text(vm.graphMark)
                                    .font(.custom("digital-7", size: 15))
                                    .foregroundColor(cvm.orange)
                            }
                     
                            
                            Text("\(vm.nodes)")
                                .font(.custom("digital-7", size: 15))
                                .foregroundColor(cvm.orange)
                            
                            Rectangle()
                                .frame(width: 1, height: 17)
                                .foregroundColor(cvm.orange)
                            
                            Text(vm.whileCount)
                                .font(.custom("digital-7", size: 15))
                                .foregroundColor(cvm.orange)
                
                            
                            Text("\(vm.whileCountCounter)")
                                .font(.custom("digital-7", size: 15))
                                .foregroundColor(cvm.orange)
                            Rectangle()
                                .frame(width: 1, height: 17)
                                .foregroundColor(cvm.orange)
                            
                            Text(vm.forCount)
                                .font(.custom("digital-7", size: 15))
                                .foregroundColor(cvm.orange)
                            
                            Text("\(vm.forCountCounter)")
                                .font(.custom("digital-7", size: 15))
                                .foregroundColor(cvm.orange)
                            
                            
                        }
                       

                    }
                    Spacer()

                }

                // Button Panel as an Overlay
                VStack {
                    Spacer()
                        .frame(height: 440)
                    ButtonsView()
                        .frame(width: 305, height: 200)
                    Spacer()
                }
            }
            Spacer()
                .frame(height: 100)
            Image(systemName: "line.3.horizontal.decrease").resizable().frame(width:50, height: 20)
                .foregroundColor(cvm.dragDownMenu)
            Spacer()
                .frame(height: 50)
            
            ZStack {
                // demonstration display for space time complexity and pseudo code
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient (

                            gradient: Gradient(colors: [cvm.demonstrationdisplayTop, cvm.demonstrationdisplayBottom]),
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                    .frame(width: 350, height: 400)
                
                // Algorithm pseudo code
                if vm.selectAlgorithm == "bubble" {
                    VStack {
                        Spacer()
                            .frame(height: 90)
                        HStack {
                            Text(textVm.pseudoCode)
                                .font(.custom("SourceCodePro-Medium", size: 15))
                                .font(.system(size: 20))
                                .foregroundColor(Color.white)
                                .frame(width: 500, height: 300)
                            Spacer()
                                .frame(width: 200)
                            
                        }
                    }
                } else if vm.selectAlgorithm == "insertion" {
                    VStack {
                        Spacer()
                            .frame(height: 20)
                        HStack {
                      
                            Text(textVm.pseudoCode)
                                .font(.custom("SourceCodePro-Medium", size: 14))
                                .foregroundColor(Color.white)
                                .frame(width: 500, height: 300)
                          
                            Spacer()
                                .frame(width: 50)
                        }
                    }

                } else if vm.selectAlgorithm == "quick" {
                    VStack {
                        Spacer()
                            .frame(height: 0)
                        HStack {
                            Text(textVm.pseudoCode)
                                .font(.custom("SourceCodePro-Medium", size: 10))
                               .foregroundColor(Color.white)
                                .frame(width: 400, height: 200)
                            Spacer()
                                .frame(width: 50)
                        }
                    }
                } else if vm.selectAlgorithm == "radix" {
                    ScrollView {
                    VStack {
                        Spacer()
                            .frame(height: 0)
                     
                        HStack {
                                Text(textVm.pseudoCode)
                                    .font(.custom("SourceCodePro-Medium", size: 9))
                                    .foregroundColor(Color.white)
                                    .frame(width: 600, height: 500)
                            Spacer()
                                .frame(width: 50)
                         
                        }
                            Spacer()
                                .frame(width: 50)
                        }
                    }
                    .frame(width: 400, height: 200)
                }   else if vm.selectAlgorithm == "bitonic" {
                    ScrollView {
                    VStack {
                        Spacer()
                            .frame(height: 0)
                     
                        HStack {
                                Text(textVm.pseudoCode)
                                    .font(.custom("SourceCodePro-Medium", size: 9))
                                    .foregroundColor(Color.white)
                                    .frame(width: 600, height: 500)
                            Spacer()
                                .frame(width: 50)
                         
                        }
                            Spacer()
                                .frame(width: 50)
                        }
                    }
                    .frame(width: 400, height: 200)
                }
                
                VStack {
                    Spacer()
                        .frame(height: 30)

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
                            .font(.custom("SourceCodePro-Medium", size: 7))
                            .frame(width: 100.0, height: 20.0)
                            .position(x: 146, y: 8)
                            .underline(false)
                        
                        Text("O(n^2) Time | O(1) Space")
                            .font(.custom("SourceCodePro-Medium", size: 13))
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
                            .font(.custom("SourceCodePro-Medium", size: 10))
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
                                .font(.custom("SourceCodePro-Medium", size: 10))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -5, y: 280)
                            Rectangle()
                                .frame(width: 238, height: 1)
                                .foregroundColor(Color.white)
                                .position(x: -105, y: 260)
                            Text("O(1)")
                                .underline(false)
                                .font(.custom("SourceCodePro-Medium", size: 12))
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
                                .font(.custom("SourceCodePro-Medium", size: 12))
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
                        
                        
                    } else if vm.selectAlgorithm == "quick" {
                        
                        Button {
                            
                            withAnimation(Animation.spring()) {
                                vm.expand3.toggle()
                                vm.showGraph = 1
                                vm.toggleGraph.toggle()
                            }
                            
                        }
                        
                        
                    label: {
                        
                        Text("(AVRAGE CASE)")
                            .font(.custom("SourceCodePro-Medium", size: 7))
                            .frame(width: 100.0, height: 20.0)
                            .position(x: 146, y: 8)
                            .underline(false)
                        
                        Text("O(nlog(n)) Time | O(1) Space")
                            .font(.custom("SourceCodePro-Medium", size: 12))
                            .frame(width: 300.0, height: 20.0)
                            .position(x: 90, y: 23)
                            .underline(false)
                        
                        RoundedRectangle(cornerRadius: 100)
                            .frame(width: 50, height: 4)
                            .foregroundColor(cvm.blurredPurple)
                            .position(x: vm.expand3 ? 50 : 50, y: vm.expand3 ? 290 : 39 )
                        Rectangle()
                            .frame(width: 3, height: 200)
                            .foregroundColor(Color.white)
                            .position(x: -120, y: 170)
                        Text("TIME")
                            .underline(false)
                            .font(.custom("SourceCodePro-Medium", size: 10))
                            .rotationEffect(.degrees(270))
                            .frame(width: 300.0, height: 20.0)
                            .position(x: -178, y: 85)
                        ZStack {
                            Rectangle()
                                .frame(width: 238, height: 3)
                                .foregroundColor(Color.white)
                                .position(x: -98, y: 270)
                            Text("SPACE")
                                .underline(false)
                                .font(.custom("SourceCodePro-Medium", size: 10))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: 2, y: 280)
                            Rectangle()
                                .frame(width: 238, height: 1)
                                .foregroundColor(Color.white)
                                .position(x: -98, y: 260)
                            Text("O(1)")
                                .underline(false)
                                .font(.custom("SourceCodePro-Medium", size: 12))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -30, y: 250)
                            Rectangle()
                                .rotationEffect(.degrees(145))
                                .frame(width: 270, height: 1)
                                .foregroundColor(Color.white)
                                .position(x: -105, y: 182)
                            Text("O(nlog(n))")
                                .underline(false)
                                .font(.custom("SourceCodePro-Medium", size: 12))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -130, y: 160)
                            
                        }
                    }
                    .frame(width: 280)
                    .frame(height: vm.expand3 ? 300 : 45)
                    .foregroundColor(Color.white)
                    .buttonStyle(.borderless)
                    .background(cvm.purple)
                    .cornerRadius(20)
                        
                    } else if vm.selectAlgorithm == "radix" {
                        Button {
                            
                            withAnimation(Animation.spring()) {
                                vm.expand3.toggle()
                                vm.showGraph = 1
                                vm.toggleGraph.toggle()
                            }
                            
                        }
                        
                        
                    label: {
                        
                        Text("(AVRAGE CASE)")
                            .font(.custom("SourceCodePro-Medium", size: 7))
                            .frame(width: 100.0, height: 20.0)
                            .position(x: 146, y: 8)
                            .underline(false)
                        
                        Text("O(nlog(n)) Time | O(1) Space")
                            .font(.custom("SourceCodePro-Medium", size: 12))
                            .frame(width: 300.0, height: 20.0)
                            .position(x: 90, y: 23)
                            .underline(false)
                        
                        RoundedRectangle(cornerRadius: 100)
                            .frame(width: 50, height: 4)
                            .foregroundColor(cvm.blurredPurple)
                            .position(x: vm.expand3 ? 50 : 50, y: vm.expand3 ? 290 : 39 )
                        Rectangle()
                            .frame(width: 3, height: 200)
                            .foregroundColor(Color.white)
                            .position(x: -120, y: 170)
                        Text("TIME")
                            .underline(false)
                            .font(.custom("SourceCodePro-Medium", size: 10))
                            .rotationEffect(.degrees(270))
                            .frame(width: 300.0, height: 20.0)
                            .position(x: -178, y: 85)
                        ZStack {
                            Rectangle()
                                .frame(width: 238, height: 3)
                                .foregroundColor(Color.white)
                                .position(x: -98, y: 270)
                            Text("SPACE")
                                .underline(false)
                                .font(.custom("SourceCodePro-Medium", size: 10))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: 2, y: 280)
                            Rectangle()
                                .frame(width: 238, height: 1)
                                .foregroundColor(Color.white)
                                .position(x: -98, y: 260)
                            Text("O(1)")
                                .underline(false)
                                .font(.custom("SourceCodePro-Medium", size: 12))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -30, y: 250)
                            Rectangle()
                                .rotationEffect(.degrees(145))
                                .frame(width: 270, height: 1)
                                .foregroundColor(Color.white)
                                .position(x: -105, y: 182)
                            Text("O(nlog(n))")
                                .underline(false)
                                .font(.custom("SourceCodePro-Medium", size: 12))
                                .frame(width: 300.0, height: 20.0)
                                .position(x: -130, y: 160)
                            
                        }
                    }
                    .frame(width: 280)
                    .frame(height: vm.expand3 ? 300 : 45)
                    .foregroundColor(Color.white)
                    .buttonStyle(.borderless)
                    .background(cvm.purple)
                    .cornerRadius(20)
                    }
                    
                    Spacer()
                    
                    
                    
                }
                }
            
    }
        .environment(\.sizeCategory, .medium)

        .frame(minWidth: 430, maxWidth: 430, minHeight: 100, maxHeight: 1200)

        .background(LinearGradient (
            
            gradient: Gradient(colors: [cvm.blue, cvm.black]),
            startPoint: .top,
            endPoint: .bottom)
                    
    )

            
            
      
    }

    }
    

struct ChartView: View {
    // Back-end view model
    @ObservedObject var vm = SortifyViewModel.shared
    @ObservedObject var textVm = TextViewModel.shared
    // color view model
    @ObservedObject var cvm = ColorViewModel()
    var body: some View {
        HStack {
            Spacer()
                .frame(width: vm.nodes < 35 ? 20 : 50)
          
                    
                    // if else statement to choose between bar graph, point graph, line graph
                    if vm.selectGraph == ".bar" {
                        Chart {
                                ForEach(Array(zip(vm.data.indices, vm.data.filter { $0 <= vm.nodes })), id: \.0) { index, item in
                                    BarMark(x: .value("Position", index), y: .value("Value", item))
                                        .foregroundStyle(vm.swapColors(value: item))
                                }
                            }
                         

                    } else if vm.selectGraph == ".point" {
                        Chart {
                            ForEach(Array(zip(vm.data.indices, vm.data.filter { $0 <= vm.nodes })), id: \.0) { index, item in
                                PointMark(x: .value("Position", index), y: .value("Value", item))
                                    .foregroundStyle(vm.swapColors(value: item))
                            }
                        }
                    } else if vm.selectGraph == ".line" {
                        Chart {
                            ForEach(Array(zip(vm.data.indices, vm.data.filter { $0 <= vm.nodes })), id: \.0) { index, item in
                                LineMark(x: .value("Position", index), y: .value("Value", item))
                                    .foregroundStyle(vm.swapColorsTwo(valueTwo: item)) // line graph
                            }
                        }
                    } else if vm.selectGraph == ".area" {
                        Chart {
                            ForEach(Array(zip(vm.data.indices, vm.data.filter { $0 <= vm.nodes })), id: \.0) { index, item in
                                AreaMark(x: .value("Position", index), y: .value("Value", item))
                                    .foregroundStyle(vm.swapColorsTwo(valueTwo: item)) // line graph
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
                .frame(width: vm.nodes < 35 ? 330 : 390, height: vm.nodes < 35 ? 350 : 405)
                .onAppear {
                    vm.data = vm.generateInput()
                }
    }
}

struct ButtonsView: View {
    // Back-end view model
    @ObservedObject var vm = SortifyViewModel.shared
    
    @ObservedObject var textVm = TextViewModel.shared
    
    // color view model
    @ObservedObject var cvm = ColorViewModel()
    var body: some View {
       ZStack {
            // control pane for the buttons
            RoundedRectangle(cornerRadius: 25)
                                    .fill(
                                        LinearGradient (
            
                                            gradient: Gradient(colors: [cvm.controlBackgroundBlue, cvm.controlBackgroundBlack]),
                                            startPoint: .top,
                                            endPoint: .bottom)
                                    )
                .frame(width: 305, height: 200)
            
            HStack {
                VStack {
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
                                
                            } else if vm.selectAlgorithm == "bitonic" {
                                try await vm.sort()
                                try await vm.swooping()
                                
                            } else if vm.selectAlgorithm == "cocktailShaker" {
                                try await vm.cocktailShakerSort()
                                try await vm.swooping()
                            }
                        }
                    }
                label: {
                    Text("SORT     ")
                        .font(.custom("SourceCodePro-Medium", size: 12))
                        .underline(false)
                    Image(systemName: "play.fill")
                        .resizable().frame(width: 15, height: 15)
                }
                    
                .disabled(vm.isSorting || vm.sortComplete || vm.isSwooping )
                    
                .frame(width: 130, height: 37)
                .foregroundColor(vm.isSorting || vm.isSwooping ? Color.gray : Color.white)
                .buttonStyle(.borderless)
                .background(cvm.purple)
                .cornerRadius(20)
                
                    
                    // reset button that shuffles the data variable
                    Button {
                        
                        
                        Task {
                            
                            
                            try await vm.fisherYatesShuffle()
                            
                        }
                    }
                    
                label: {
                    Text("RESET   ")
                        .font(.custom("SourceCodePro-Medium", size: 12))
                        .underline(false)
                    
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable().frame(width: 20, height: 20)
                }
                    
                .disabled(vm.isSorting || vm.isSwooping)
                .frame(width: 130, height: 38)
                .foregroundColor(vm.isSorting || vm.isSwooping ? Color.gray : Color.white)        .buttonStyle(.borderless)
                .background(cvm.purple)
                .cornerRadius(20)
                    
                    Spacer()
                        .frame(height: 30)
                    Slider(value: $vm.sliderValue, in: 0.9999999999...99.9999999999)
                    
                        .accentColor(cvm.purple)
                        .frame(width: 120, height: 10)
                }
                .padding(.bottom, 10)
                VStack {
                    VStack(alignment: .center, spacing: 0, content:  {
                        
                        // Algorithms buttons
                        HStack {
                            Spacer()
                                .frame(width: 10)
                            Text("ALGORITHMS")
                                .font(.custom("SourceCodePro-Medium", size: 12))
                            Image(systemName: "wand.and.stars").resizable().frame(width: 20, height: 20)
                        }.onTapGesture {
                            withAnimation(.spring(response: 0.15)) {
                                vm.expand.toggle()
                                if vm.expand {
                                    vm.algorithmsButtonHeight = 290
                                    vm.algorithmsButtonScrollHeight = 190
                                    vm.nodesButtonHeight = 0
                                    vm.graphsButtonHeight = 0
                                } else if vm.expand == false {
                                    vm.graphsButtonHeight = 40
                                    vm.nodesButtonHeight = 40
                                    vm.algorithmsButtonHeight = 40
                                    vm.algorithmsButtonScrollHeight = 0

                                }
                            }
                            vm.algoButtonPressed.toggle()
                        }
                        .foregroundColor(vm.isSorting || vm.isSwooping ? Color.gray : Color.white)       .disabled(vm.isSorting || vm.isSwooping)
                        ScrollView(showsIndicators: true) {
                            if vm.expand {
                                
                                ZStack {
                                // button that triggers bubble sort for the sort button
                                Button(action:  {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                        vm.expand.toggle()
                                        vm.graphsButtonHeight = 40
                                        vm.nodesButtonHeight = 40
                                        vm.algorithmsButtonHeight = 40
                                        vm.algorithmsButtonScrollHeight = 0
                                        
                                    }
                                    vm.myTitle = "bubbleSort()"
                                    vm.selectAlgorithm = "bubble"
                                    vm.algoButtonPressed.toggle()
                                    textVm.pseudoCode = """
                                                    func bubbleSort()
                                                        isSorted = false
                                                        count = 0
                                                        while not isSorted
                                                        isSorted = true
                                                        
                                                        for j in range(0, arr - count)
                                                        if array[j] > array[j+1]:
                                                            swap(i, i + 1)
                                                            isSorted = false
                                                    
                                                    
                            """
                                }) {
                                    Text("bubble sort").padding()
                                        .font(.custom("SourceCodePro-Medium", size: 15))
                                        .underline(false)
                                    
                                }
                                
                                .buttonStyle(.borderless)
                                .foregroundColor(Color.white)
                                
                                Rectangle()
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.white)
                                    .frame(width: 110, height: 40)
                                
                            }
                                
                                
                                ZStack {
                                    // button that triggers selection sort for the sort button
                                    Button(action: {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                            vm.expand.toggle()
                                            vm.graphsButtonHeight = 40
                                            vm.nodesButtonHeight = 40
                                            vm.algorithmsButtonHeight = 40
                                            vm.algorithmsButtonScrollHeight = 0
                                            
                                        }
                                        vm.myTitle = "insertionSort()"
                                        vm.selectAlgorithm = "insertion"
                                        vm.algoButtonPressed.toggle()
                                        textVm.pseudoCode = """
        func insertionSort(array):
        for i in 0 ..< array.count:
            j = i
            
        while j >= 0, array[j] > array[i - 1]
                array[j  +  1] = array[j]
                j -= 1
                swap()

            return array
"""
                                        
                                        
                                    }) {
                                        HStack {
                                            Text("insertion sort").padding()
                                                .font(.custom("SourceCodePro-Medium", size: 15))
                                                .underline(false)
                                        }
                                    }
                                    .buttonStyle(.borderless)
                                    .foregroundColor(Color.white)
                                    Rectangle()
                                        .stroke(lineWidth: 1)
                                        .foregroundColor(.white)
                                        .frame(width: 110, height: 40)
                                }
                                
                                    ZStack {
                                // button that triggers heap sort for the sort button
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                        vm.expand.toggle()
                                        vm.graphsButtonHeight = 40
                                        vm.nodesButtonHeight = 40
                                        vm.algorithmsButtonHeight = 40
                                        vm.algorithmsButtonScrollHeight = 0
                                        
                                    }
                                    
                                    vm.myTitle = "quickSort()"
                                    vm.selectAlgorithm = "quick"
                                    vm.algoButtonPressed.toggle()
                                    textVm.pseudoCode = """
        function quickSort(array, start, end):
            if start < end:
            pivotIndex = partition(array, start, end)
            quickSort(array, start, pivotIndex - 1)
            quickSkort(array, pivotIndex + 1, end)

        function partition(array, start, end):
            pivot = array[end]
            i = start - 1
            while start <= end:
            if array[j] <= pivot:
                    i += 1
                    array[i], array[j] = array[j], array[i]
            array[i + 1], array[end] = array[end], array[i + 1]
"""
                                    
                                }) {
                                    Text("quick sort").padding()
                                        .font(.custom("SourceCodePro-Medium", size: 15))
                                        .underline(false)
                                    
                                } .buttonStyle(.borderless)
                                    .foregroundColor(Color.white)
                                
                                Rectangle()
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.white)
                                    .frame(width: 110, height: 40)
                            }
                                
                                
                                
                                ZStack {
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                        vm.expand.toggle()
                                        vm.graphsButtonHeight = 40
                                        vm.nodesButtonHeight = 40
                                        vm.algorithmsButtonHeight = 40
                                        vm.algorithmsButtonScrollHeight = 0
                                        
                                    }
                                    
                                    vm.myTitle = "RadixSort()"
                                    vm.selectAlgorithm = "radix"
                                    vm.algoButtonPressed.toggle()
                                    textVm.pseudoCode = """
        func countingSort(by place: Int) async throws {
            let radix = 10
            var count = [Int](repeating: 0, count: radix)
            var output = [Int](repeating: 0, count: data.count)
            
            for number in data {
                let digit = getDigit(number, at: place)
                count[digit] += 1
            }
            
            for i in 1..<radix {
                count[i] += count[i - 1]
            }
            
            for number in data.reversed() {
                let digit = getDigit(number, at: place)
                count[digit] -= 1
                output[count[digit]] = number
            }
            
            for i in 0..<data.count {
                data[i] = output[i]
            }
        }
        
        func getMax() -> Int {
            guard let max = data.max() else {
                fatalError("Array is empty")
            }
            return max
        }
        
        func radixSort() async throws {
         
            isSorting = true
            let maxNumber = getMax()
            var place = 1
            
            while maxNumber / place > 0 {

                whileCountCounter += 1
                try await countingSort(by: place)
                place *= 10
            }
            
            sortComplete = true
        }

"""
                                    
                                }) {
                                    Text("Radix sort").padding()
                                        .font(.custom("SourceCodePro-Medium", size: 15))
                                        .underline(false)
                                    
                                } .buttonStyle(.borderless)
                                    .foregroundColor(Color.white)
                                
                                Rectangle()
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.white)
                                    .frame(width: 110, height: 40)
                            }
                                
                                ZStack {
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                        vm.expand.toggle()
                                        vm.graphsButtonHeight = 40
                                        vm.nodesButtonHeight = 40
                                        vm.algorithmsButtonHeight = 40
                                        vm.algorithmsButtonScrollHeight = 0
                                        
                                    }
                                    
                                    vm.myTitle = "BitonicSort()"
                                    vm.selectAlgorithm = "bitonic"
                                    vm.algoButtonPressed.toggle()
                                    textVm.pseudoCode = """
        func countingSort(by place: Int) async throws {
            let radix = 10
            var count = [Int](repeating: 0, count: radix)
            var output = [Int](repeating: 0, count: data.count)
            
            for number in data {
                let digit = getDigit(number, at: place)
                count[digit] += 1
            }
            
            for i in 1..<radix {
                count[i] += count[i - 1]
            }
            
            for number in data.reversed() {
                let digit = getDigit(number, at: place)
                count[digit] -= 1
                output[count[digit]] = number
            }
            
            for i in 0..<data.count {
                data[i] = output[i]
            }
        }
        
        func getMax() -> Int {
            guard let max = data.max() else {
                fatalError("Array is empty")
            }
            return max
        }
        
        func radixSort() async throws {
         
            isSorting = true
            let maxNumber = getMax()
            var place = 1
            
            while maxNumber / place > 0 {

                whileCountCounter += 1
                try await countingSort(by: place)
                place *= 10
            }
            
            sortComplete = true
        }

"""
                                    
                                }) {
                                    Text("Bitonic Sort").padding()
                                        .font(.custom("SourceCodePro-Medium", size: 15))
                                        .underline(false)
                                    
                                } .buttonStyle(.borderless)
                                    .foregroundColor(Color.white)
                                
                                Rectangle()
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.white)
                                    .frame(width: 110, height: 40)
                            }
                            ZStack {
                     
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                        vm.expand.toggle()
                                        vm.graphsButtonHeight = 40
                                        vm.nodesButtonHeight = 40
                                        vm.algorithmsButtonHeight = 40
                                        vm.algorithmsButtonScrollHeight = 0
                                        
                                    }
                                    
                                    vm.myTitle = "cocktailShakerSort()"
                                    vm.selectAlgorithm = "cocktailShaker"
                                    vm.algoButtonPressed.toggle()
                                    textVm.pseudoCode = """
        func countingSort(by place: Int) async throws {
            let radix = 10
            var count = [Int](repeating: 0, count: radix)
            var output = [Int](repeating: 0, count: data.count)
            
            for number in data {
                let digit = getDigit(number, at: place)
                count[digit] += 1
            }
            
            for i in 1..<radix {
                count[i] += count[i - 1]
            }
            
            for number in data.reversed() {
                let digit = getDigit(number, at: place)
                count[digit] -= 1
                output[count[digit]] = number
            }
            
            for i in 0..<data.count {
                data[i] = output[i]
            }
        }
        
        func getMax() -> Int {
            guard let max = data.max() else {
                fatalError("Array is empty")
            }
            return max
        }
        
        func radixSort() async throws {
         
            isSorting = true
            let maxNumber = getMax()
            var place = 1
            
            while maxNumber / place > 0 {

                whileCountCounter += 1
                try await countingSort(by: place)
                place *= 10
            }
            
            sortComplete = true
        }

"""
                                    
                                }) {
                                    Text("Cocktail Shaker Sort").padding()
                                        .font(.custom("SourceCodePro-Medium", size: 15))
                                        .underline(false)
                                    
                                }
                                
                                .buttonStyle(.borderless)
                                .foregroundColor(Color.white)
             
                                Rectangle()
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.white)
                                    .frame(width: 110, height: 40)
                            }
                            }
                        }
                        .frame(width: 130, height: vm.algorithmsButtonScrollHeight)
                        
                        if vm.expand {
                            Image(systemName: "chevron.down").resizable().frame(width: 50, height: 10)

                                .foregroundColor(.white)
                                .padding(.top, 20)

                        }
                    })
                    .frame(width: 130, height: vm.algorithmsButtonHeight)
                    .background(cvm.purple)
                    .cornerRadius(20)
                    .disabled(vm.expand2 || vm.expand4)

                    
                    // place buttons here ...
                    VStack(alignment: .leading, content:  {
                        
                        
                        HStack {
                            
                            
                            // graph button title
                            Text("    GRAPHS")
                                .font(.custom("SourceCodePro-Medium", size: 15))
                  
                        
                            Image(systemName: "chart.bar.fill").resizable().frame(width: 20, height: 20)
                            Spacer()
                                .frame(width: 18)
                        }.onTapGesture {
                            withAnimation(.spring(response: 0.15)) {
                                vm.expand2.toggle()
                                if vm.expand2 {
                                    vm.graphsButtonHeight = 290
                                    vm.algorithmsButtonHeight = 0
                                    vm.nodesButtonHeight = 0
                                } else if vm.expand2 == false {
                                    vm.graphsButtonHeight = 40
                                    vm.nodesButtonHeight = 40
                                    vm.algorithmsButtonHeight = 40


                                }
                                
                            }
                        }
                        .foregroundColor(vm.isSorting || vm.isSwooping ? Color.gray : Color.white) .disabled(vm.isSorting || vm.isSwooping)
                        
                        
                        
                        if vm.expand2 {
                            
                            // button for bar graph
                            Button(action:  {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                    vm.expand2.toggle()
                                    vm.graphsButtonHeight = 40
                                    vm.nodesButtonHeight = 40
                                    vm.algorithmsButtonHeight = 40


                                }
                                
                                vm.graphMark = "bar:"
                                vm.selectGraph = ".bar"
                                
                                
                            })
                            {
                                Text("bar graph").padding()
                                    .font(.custom("SourceCodePro-Medium", size: 15))
                                    .underline(false)
                                
                            }
                            .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                            
                            // button for point graph
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                    vm.expand2.toggle()
                                    vm.graphsButtonHeight = 40
                                    vm.nodesButtonHeight = 40
                                    vm.algorithmsButtonHeight = 40


                                }
                                vm.graphMark = "point:"
                                vm.selectGraph = ".point"
                                
                                
                            }) {
                                Text("point graph").padding()
                                    .font(.custom("SourceCodePro-Medium", size: 15))
                                    .underline(false)
                                
                            }
                            .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                            
                            // button for line graph
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                    vm.expand2.toggle()
                                    vm.graphsButtonHeight = 40
                                    vm.nodesButtonHeight = 40
                                    vm.algorithmsButtonHeight = 40


                                }
                                
                                vm.graphMark = "line:"
                                vm.selectGraph = ".line"
                                
                                
                            }) {
                                Text("line graph").padding()
                                    .font(.custom("SourceCodePro-Medium", size: 15))
                                    .underline(false)
                                
                            }
                            .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                            
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                    vm.expand2.toggle()
                                    vm.graphsButtonHeight = 40
                                    vm.nodesButtonHeight = 40
                                    vm.algorithmsButtonHeight = 40

                                }
                                
                                vm.graphMark = "area:"
                                vm.selectGraph = ".area"
                                
                                
                            }) {
                                Text("area graph").padding()
                                    .underline(false)
                                
                            }
                            .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                        }
                    })
                    
                    
                    .frame(width: 130, height: vm.graphsButtonHeight)
                    .background(cvm.purple)
                    .cornerRadius(20)
                    .disabled(vm.expand || vm.expand4)

                    
                    VStack(alignment: .leading, content:  {
                        
                        
                        
                        HStack {
                            
                            // graph button title
                            Text("    NODES    ")
                                .font(.custom("SourceCodePro-Medium", size: 15))
                            
                            Image(systemName: "point.3.connected.trianglepath.dotted").resizable().frame(width: 20, height: 20)
                            
                            Spacer()
                                .frame(width: 20)
                        }.onTapGesture {
                            withAnimation(.spring(response: 0.15)) {
                                vm.expand4.toggle()
                                vm.algorithmsButtonHeight = 0
                                vm.graphsButtonHeight = 0
                                if vm.expand4 {
                                    vm.nodesButtonHeight = 170
                                    
                                } else if vm.expand4 == false {
                                    vm.algorithmsButtonHeight = 40
                                    vm.graphsButtonHeight = 40
                                    vm.nodesButtonHeight = 40
                                
                                }
                            }
                        }
                        .disabled(vm.expand || vm.expand2)
                        .foregroundColor(vm.isSorting || vm.isSwooping ? Color.gray : Color.white) .disabled(vm.isSorting || vm.isSwooping)
                        
                        
                        
                        if vm.expand4 {
                            
                            // button for bar graph
                            Button(action:  {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                    vm.expand4.toggle()
                                    
                                        vm.nodesButtonHeight = 40
                                        vm.graphsButtonHeight = 40
                                        vm.algorithmsButtonHeight = 40

                                    
                                }
                                
                                vm.nodes = 10
                                vm.data = vm.generateInput()
                             
                                
                            })
                            {
                                HStack {
                                    Spacer()
                                        .frame(width: 10)
                                    Text("10 nodes").padding()
                                        .font(.custom("SourceCodePro-Medium", size: 15))
                                        .underline(false)
                                }
                                
                            }
                            .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                            // button for point graph
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                                    vm.expand4.toggle()
                                    
                                        vm.nodesButtonHeight = 40
                                        vm.graphsButtonHeight = 40
                                        vm.algorithmsButtonHeight = 40

                                }
                                vm.nodes = 35
                                vm.data = vm.generateInput()
                                
                                
                                
                            }) {
                                HStack {
                                    Spacer()
                                        .frame(width: 10)
                                    Text("35 nodes").padding()
                                        .font(.custom("SourceCodePro-Medium", size: 15))
                                        .underline(false)
                                }
                                
                            }
                            .buttonStyle(.borderless)
                            .foregroundColor(Color.white)
                            
                            
                            
                        }
                    })
                    
                    .frame(width: 130, height: vm.nodesButtonHeight)
                    .background(cvm.purple)
                    .cornerRadius(20)
                    .disabled(vm.expand || vm.expand2)

                    
                }
            }
        }
    }
}

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            
            
            ContentView()
        }
        
    }

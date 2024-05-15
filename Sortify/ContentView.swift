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
                    
                    ZStack {
                        VStack {
                            Spacer()
                                .frame(height: 20)
                            HStack {
                                Text(textVm.pseudoCode)
                                    .font(.custom("SourceCodePro-Medium", size: 10))
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.white)
                                    .frame(width: 500, height: 300)
                                Spacer()
                                    .frame(width: 20)
                                
                            }
                        }
                        Rectangle()
                            .stroke(lineWidth: 1)
                            .frame(width: 300, height: 280)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 50)
                } else if vm.selectAlgorithm == "insertion" {
                    ZStack {
                        ScrollView([.horizontal, .vertical]) {
                            
                                VStack {
                                    
                                    HStack {
                                        
                                        Text(textVm.pseudoCode)
                                            .font(.custom("SourceCodePro-Medium", size: 13))
                                            .foregroundColor(Color.white)
                                            .frame(width: 400, height: 300)
                                            .padding(.top, 30)
                                        
                                        Spacer()
                                            .frame(height: 150)
                                    }
                                }
                                
                        
                            
                       
                        }
                        .frame(width: 300, height: 280)

                        Rectangle()
                            .stroke(lineWidth: 1)
                            .frame(width: 300, height: 280)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 50)

                } else if vm.selectAlgorithm == "quick" {
                    ZStack {
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
                        Rectangle()
                            .stroke(lineWidth: 1)
                            .frame(width: 340, height: 280)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 50)
                } else if vm.selectAlgorithm == "radix" {
                    ZStack {
                        ScrollView {
                            VStack {
                                Spacer()
                                    .frame(height: 0)
                                
                                HStack {
                                    Text(textVm.pseudoCode)
                                        .font(.custom("SourceCodePro-Medium", size: 9))
                                        .foregroundColor(Color.white)
                                        .frame(width: 600, height: 600)
                                    Spacer()
                                        .frame(width: 50)
                                    
                                }
                                Spacer()
                                    .frame(width: 50)
                            }
                        }
                        .frame(width: 340, height: 280)
                        Rectangle()
                            .stroke(lineWidth: 1)
                            .frame(width: 340, height: 280)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 50)
                }   else if vm.selectAlgorithm == "bitonic" {
                    ZStack {
                        ScrollView {
                            VStack {
                                Spacer()
                                    .frame(height: 0)
                                
                                HStack {
                                    Text(textVm.pseudoCode)
                                        .font(.custom("SourceCodePro-Medium", size: 9))
                                        .foregroundColor(Color.white)
                                        .frame(width: 600, height: 600)
                                    Spacer()
                                        .frame(width: 50)
                                    
                                }
                                Spacer()
                                    .frame(width: 50)
                            }
                        }
                        .frame(width: 340, height: 280)
                        
                        Rectangle()
                            .stroke(lineWidth: 1)
                            .frame(width: 340, height: 280)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 50)
                } else if vm.selectAlgorithm == "cocktailShaker" {
                    ZStack {
                    ScrollView {
                        VStack {
                            Spacer()
                                .frame(height: 0)
                            
                            HStack {
                                Text(textVm.pseudoCode)
                                    .font(.custom("SourceCodePro-Medium", size: 9))
                                    .foregroundColor(Color.white)
                                    .frame(width: 600, height: 600)
                                Spacer()
                                    .frame(width: 50)
                                
                            }
                            Spacer()
                                .frame(width: 50)
                        }
                    }
                    .frame(width: 340, height: 280)
                        Rectangle()
                            .stroke(lineWidth: 1)
                            .frame(width: 340, height: 280)
                            .foregroundColor(.white)
                }
                    .padding(.top, 50)

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
                        
                        
                    } else if vm.selectAlgorithm == "bitonic" {
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
                    } else if vm.selectAlgorithm == "cocktailShaker" {
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
def bubble_sort(arr):
    n = len(arr)  # Get the length of the array
    
    # Traverse through all array elements
    for i in range(n):
        # Initialize a flag to detect if any swap happens
        swapped = False
        
        # Last i elements are already sorted,
        # so we do not need to check them
        for j in range(0, n - i - 1):
            # Traverse the array from 0 to n-i-1
            # Swap if the element found is
            # greater than the next element
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]  # Swap elements
                swapped = True
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
def insertion_sort(arr):
    # Traverse through 1 to len(arr)
    for i in range(1, len(arr)):
        key = arr[i]  # Current element to be inserted
        j = i - 1  # Index of the previous element

        # Move elements of arr[0..i-1], that are greater than key,
        # to one position ahead of their current position
        while j >= 0 and arr[j] > key:
            arr[j + 1] = arr[j]
            j -= 1
        # Place the key element at the correct position
        arr[j + 1] = key

# Example usage
arr = [12, 11, 13, 5, 6]
insertion_sort(arr)
print("Sorted array:", arr)

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
def quicksort(arr):
    # Helper function to partition the array
    def partition(low, high):

        # Choose the rightmost element as the pivot
        pivot = arr[high]
        i = low - 1  # Pointer for the greater element
        for j in range(low, high):
            if arr[j] <= pivot:
                i += 1  # Move the pointer to the right
                arr[i], arr[j] = arr[j], arr[i]  # Swap elements

         # Swap the pivot element to its correct position
    arr[i + 1], arr[high] = arr[high], arr[i + 1]
        return i + 1  # Return the partition point

    # Helper function to perform quicksort
    def quicksort_recursive(low, high):
        if low < high:
             # Partition the array and get the pivot index
            pi = partition(low, high)

            # Recursively sort the elements before the pivot
            quicksort_recursive(low, pi - 1)

             # Recursively sort the elements after the pivot
            quicksort_recursive(pi + 1, high)
     # Start the recursive quicksort
    quicksort_recursive(0, len(arr) - 1)
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
def counting_sort(arr, exp):
    n = len(arr)
# Output array to store sorted numbers
    output = [0] * n

# Count array to store the count of occurrences of digits (0-9)
    count = [0] * 10

    # Store the count of occurrences of each digit in count[]
    for i in range(n):
        index = (arr[i] // exp) % 10
        count[index] += 1

    # Change count[i] so that it contains 
    # the actual position of this digit in output[]
    for i in range(1, 10):
        count[i] += count[i - 1]

    # Build the output array
    for i in range(n - 1, -1, -1):
        index = (arr[i] // exp) % 10
        output[count[index] - 1] = arr[i]
        count[index] -= 1

    # Copy the output array to arr[], 
    # so that arr[] now contains sorted numbers
    for i in range(n):
        arr[i] = output[i]

def radix_sort(arr):
    # Find the maximum number to 
    # determine the number of digits
    max_num = max(arr)

    # Do counting sort for every digit. 
    # Note that exp is 10^i where i is 
    # the current digit number
    exp = 1
    while max_num // exp > 0:
        counting_sort(arr, exp)
        exp *= 10

# Example usage
arr = [170, 45, 75, 90, 802, 24, 2, 66]
radix_sort(arr)
print("Sorted array:", arr)


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
def bitonic_sort(arr, up=True):
    # Helper function to merge a bitonic sequence
    in ascending or descending order

    def bitonic_merge(arr, low, cnt, up):
        if cnt > 1:
            k = cnt // 2

            # Compare and swap elements in the bitonic sequence
            for i in range(low, low + k):
                if (arr[i] > arr[i + k]) == up:
                    arr[i], arr[i + k] = arr[i + k], arr[i]

            # Recursively merge the two halves
            bitonic_merge(arr, low, k, up)
            bitonic_merge(arr, low + k, k, up)

    # Helper function to sort the array into a bitonic sequence
    def bitonic_sort_recursive(arr, low, cnt, up):
        if cnt > 1:
            k = cnt // 2
            # Sort the first half in ascending order
            bitonic_sort_recursive(arr, low, k, True)
            # Sort the second half in descending order
            bitonic_sort_recursive(arr, low + k, k, False)
            # Merge the entire sequence
            bitonic_merge(arr, low, cnt, up)

    # Start the recursive bitonic sort
    bitonic_sort_recursive(arr, 0, len(arr), up)




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
def cocktail_shaker_sort(arr):
    n = len(arr)
    swapped = True
    start = 0
    end = n - 1
    
    while swapped:
        swapped = False
        
        # Forward pass
        for i in range(start, end):
            if arr[i] > arr[i + 1]:
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                swapped = True
        
# If nothing moved, then the array is sorted
        if not swapped:
            break

# Otherwise reset the swapped flag,
 so that it can be used in the next stage
        swapped = False
        
# Move the end point back by one, 
because the last element is in place
        end -= 1
        
        # Backward pass
        for i in range(end - 1, start - 1, -1):
            if arr[i] > arr[i + 1]:
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                swapped = True
        
# Move the start point forward by one, 
because the first element is in place

        start += 1


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

//
//  WindowManager.swift
//  Sortify
//
//  Created by Elliot Rapp on 5/13/24.
//
import SwiftUI
import Foundation
struct WindowManager: View {
    

    
    @State private var isLoading = true
    
    var body: some View {
        Group {
#if !targetEnvironment(simulator)
            // Running on a physical device
            if isLoading {
                LoadingView()
                    .onAppear {
                        startLoadingProcess()
                    }
            } else {
                ContentView()
            }
#else
            // Running in the Xcode simulator
            ContentView()
#endif
        }
    }
    private func startLoadingProcess() {
        // Simulate a loading process, such as fetching data
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // Ensure that this is executed on the main thread
            // since it's changing the state of the view
            DispatchQueue.main.async {
                withAnimation {
                    isLoading = false  // This should dismiss LoadingView
                }
            }
        }
    }
}

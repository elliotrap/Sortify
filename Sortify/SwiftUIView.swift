//
//  SwiftUIView.swift
//  Sortify
//
//  Created by Elliot Rapp on 5/13/24.
//

import SwiftUI

struct LoadingView: View {
    // Back-end view model
    @ObservedObject var vm = SortifyViewModel.shared
    
    @ObservedObject var textVm = TextViewModel.shared
    
    // color view model
    @ObservedObject var cvm = ColorViewModel()

    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "cellularbars").resizable().frame(width: 100, height: 100)
                    .symbolEffect(
                        .variableColor
                            .iterative
                        
                    )
                    .foregroundColor(cvm.orange)
                    

                Text("Sortify")
                    .font(.custom("SourceCodePro-Bold", size: 25))
                    .foregroundColor(cvm.orange)

            }
        }
        .environment(\.sizeCategory, .medium)

        .frame(minWidth: 430, maxWidth: 430, minHeight: 100, maxHeight: 1200)

        .background(LinearGradient (
            
            gradient: Gradient(colors: [cvm.blue, cvm.black]),
            startPoint: .top,
            endPoint: .bottom))
    }
}

#Preview {
    LoadingView()
}



import Foundation
import SwiftUI

class ColorViewModel: ObservableObject {
    
    @Published var dragDownMenu = Color(red: 45 / 255, green: 35 / 255, blue: 75 / 255)
    @Published var blue = Color(red: 21 / 255, green: 36 / 255, blue: 105 / 255)
    @Published var graphBackground = Color(red: 6 / 255, green: 20 / 255, blue: 50 / 255)
    @Published var graphBackgroundBottom = Color(red: 11 / 255, green: 16 / 255, blue: 65 / 255)

    @Published var controlBackgroundBlue = Color(red: 6 / 255, green: 20 / 255, blue: 75 / 255)
    @Published var controlBackgroundBlack = Color(red: 6 / 255, green: 1 / 255, blue: 55 / 255)
    @Published var demonstrationdisplayTop = Color(red: 11 / 255, green: 16 / 255, blue: 45 / 255)
    @Published var demonstrationdisplayBottom =  Color(red: 11 / 255, green: 16 / 255, blue: 65 / 255)
    @Published var black = Color(red: 12 / 255, green: 2 / 255, blue: 43 / 255)
    @Published var purple = Color(red: 91 / 255, green: 40 / 255, blue: 163 / 255)
    @Published var blurredPurple = Color(red: 140 / 255, green: 102 / 255, blue: 185 / 255)
    @Published var orange = Color(red: 253 / 255, green: 99 / 255, blue: 79 / 255)
    
    
}



import Foundation
import SwiftUI

class ColorViewModel: ObservableObject {
    
    @Published var blue = Color(red: 21 / 255, green: 6 / 255, blue: 75 / 255)
    @Published var graphBackground = Color(red: 6 / 255, green: 1 / 255, blue: 40 / 255)
    @Published var controlBackgroundBlue = Color(red: 6 / 255, green: 1 / 255, blue: 65 / 255)
    @Published var controlBackgroundBlack = Color(red: 6 / 255, green: 1 / 255, blue: 45 / 255)
    @Published var black = Color(red: 12 / 255, green: 2 / 255, blue: 43 / 255)
    @Published var purple = Color(red: 91 / 255, green: 40 / 255, blue: 163 / 255)
    @Published var orange = Color(red: 253 / 255, green: 99 / 255, blue: 79 / 255)
    
}

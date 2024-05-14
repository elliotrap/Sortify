//
//  Text.swift
//  Sortify
//
//  Created by Elliot Rapp on 1/25/23.
//

import SwiftUI

class TextViewModel: ObservableObject {
    static var shared = TextViewModel()

    @Published var pseudoCode: String = """
                        func bubbleSort()
                            isSorted = false
                            counter = 0
                            while not isSorted
                            isSorted = true
                            
                                for j in range(0, arr - counter)
                                if array[j] > array[j+1]:
                                    swap(i, i + 1)
                                    isSorted = false
                        
                        
"""
    
}




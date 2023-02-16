//
//  Text.swift
//  Sortify
//
//  Created by Elliot Rapp on 1/25/23.
//

import SwiftUI

class TextViewModel: ObservableObject {


    @Published var pseudoCode: String = """
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
    
}




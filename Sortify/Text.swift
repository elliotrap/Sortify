//
//  Text.swift
//  Sortify
//
//  Created by Elliot Rapp on 1/25/23.
//

import SwiftUI

class TextViewModel: ObservableObject {
    @Published var prompt: String = """
Bubble sort is an algorithm that compares values that are side by side, swapping them until the information in the data structure provided is sorted. The time complexity for bubble sort is O(n^2) because after you swap all the elements, you have compared each value in the data structure. No information is being stored in memory to complete the sort, so the space complexity is O(1). Due to the algorithms inefficiency, bubble sort is not used in practice on real world applications. Although it is a great first algorithm to learn for starters.

"""

    @Published var pseudoCode: String = """
funciton bubble_sort()
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




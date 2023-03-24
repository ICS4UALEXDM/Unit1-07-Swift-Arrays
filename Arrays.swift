import Foundation
import Glibc
//
//  FileIO.swift
//
//  Created by Alex De Meo
//  Created on 2023/02/11
//  Version 1.0
//  Copyright (c) 2023 Alex De Meo. All rights reserved.
//
//  This program calculates the Energy released when mass.
// is converted to energy

// creating constants and variables
var errorMessage = ""

// Defining the file paths
let inputFile = "input3.txt"
let outputFile = "output.txt"

// opening the input file for reading
guard let input = FileHandle(forReadingAtPath: inputFile) else {
    print("Error: Cannot open input file.")
    exit(1)
}

// opening the output file for writing
guard let output = FileHandle(forWritingAtPath: outputFile) else {
    print("Error: Cannot open output file.")
    exit(1)
}

// Reading contents of input file
let inputData = input.readDataToEndOfFile()

// Converting data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("Error: Cannot convert data to string.")
    exit(1)
}

// Splitting string into separate lines
let lines = inputString.components(separatedBy: .newlines)
var ints = [Int]()
// Converting the Strings to ints and putting it into a new array
for line in lines {
    let num = Int(line)
    ints.append(num!)
}
ints.sort()
// Looping through to write each number in the Input file to the output file
for num in ints {
    let outputStr = String("\(num) ")
    output.write(outputStr.data(using: .utf8)!)
}
// Getting the mean
let mean = calcMean(numbers: ints)
// Writing to the file with the mean
let outputMean = String("\nThe mean is: \(mean)\n")
output.write(outputMean.data(using: .utf8)!)
// getting the median
let median = calcMedian(numbers: ints)
// Writing to file with the median
let outputMedian = String("The median is: \(median)\n")
output.write(outputMedian.data(using: .utf8)!)
// Getting the mode
let mode = calcMode(numbers: ints)
// Writing to file with the mode
let outputMode = String("The mode is : [")
output.write(outputMode.data(using: .utf8)!)
var modeString = ""
// Because its an array it must be iterated through to create a new string to
// write with
for num in mode {
    modeString += " \(num) "
}
output.write(modeString.data(using: .utf8)!)
let close = "]"
output.write(close.data(using: .utf8)!)

// This function calculates the mean of the dataset
func calcMean(numbers: Array<Int>) -> Double {
    var sum = 0
    // Iterating through numbers array and adding each number to the sum
    for number in numbers {
        sum += number
    }
    // Calculating the mean/average
    let sumDbl = Double(sum)
    let mean = sumDbl / Double(numbers.count)
    // returning the mean back to main
    return mean
}

// This function calculates the median from a given dataset
func calcMedian(numbers: Array<Int>) -> Double {
    var median = 0
    // Checking to see if the length of the array is even or odd
    if (numbers.count % 2 == 0) {
        // if its even calculate median this way
        median = (numbers[numbers.count / 2] + numbers[(numbers.count / 2) - 1]) / 2
    } else {
        // if its odd we calculate the median this way
        median = numbers[numbers.count / 2]
    }
    // returning the median to main as a Double
    return Double(median)
}

// This function calculates the mode within a given dataset
func calcMode(numbers: Array<Int>) -> Array<Int> {
    // Necessary variables 
    var maxRepeats = 0
    var timesRepeated = 0
    var counter = 0
    var mode = [Int]()
    // Looping through the numbers array
    for num in numbers {
        // Checking to see if we are at the last place in this array, if we
        // don't do this, we'll get a indexing error
        if (counter < numbers.count - 1) {
            // Checking to see if the number is repeated or not
            if (numbers[counter] == numbers[counter + 1]) {
                timesRepeated += 1
            } else {
                // checking to see if its a record
                if (timesRepeated > maxRepeats) {
                    // clear the mode array
                    mode.removeAll()
                    // add to the array
                    mode.append(num)
                    // updating the max needed to be a record
                    maxRepeats = timesRepeated
                } else if (timesRepeated == maxRepeats) {
                    // adding the new record
                    mode.append(num)
                }
                // resetting the repeat counter
                timesRepeated = 0
            }
        } else {
            // checking to see if its a record
            if (timesRepeated > maxRepeats) {
                // clearing the array
                mode.removeAll()
                // adding the record
                mode.append(num)
                maxRepeats = timesRepeated
            } else if (timesRepeated == maxRepeats) {
                // adding the record
                mode.append(num)
            }
            timesRepeated = 0
        }
        counter += 1
    }
    // returning to main
    return mode
}
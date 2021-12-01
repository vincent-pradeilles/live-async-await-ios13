//
//  Concurrency.swift
//  AsyncAwait-iOS13
//
//  Created by Vincent on 01/12/2021.
//

import Foundation

func aLongCall() async -> String {
    try! await Task.sleep(nanoseconds: 2_000_000_000)
    
    return "Long call completed!"
}

func anotherLongCall() async -> String {
    try! await Task.sleep(nanoseconds: 3_000_000_000)
    
    return "Another long call completed!"
}

func yetAnotherLongCall() async -> String {
    try! await Task.sleep(nanoseconds: 2_000_000_000)
    
    return "Yet another long call completed!"
}

func run() async {
    let start = Date()
    
    async let firstResult = aLongCall()
    async let secondResult = anotherLongCall()
    async let thirdResult = yetAnotherLongCall()
    
    await print(firstResult, secondResult, thirdResult)
    
    let end = Date()
    
    print("Results took \(end.timeIntervalSince(start)) second.")
    
    let results = await withTaskGroup(of: String.self) { group -> [String] in
        for _ in 0..<Int.random(in: 1..<10) {
            group.addTask {
                await aLongCall()
            }
        }
        
        var results = [String]()
        
        for await result in group {
            results.append(result)
        }
        
        return results
    }
    
    print(results)
}

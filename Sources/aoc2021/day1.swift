import Foundation
import Algorithms

func d1p1(_ contents: String) -> Int {
    let trimmed = contents.trimmingCharacters(in: .whitespacesAndNewlines)
    let lines = trimmed.components(separatedBy: "\n")
    let nums = lines.map { Int($0)! }
    var count = 0
    for i in 0..<nums.count - 1 {
        if nums[i + 1] - nums[i] > 0 {
            count += 1
        }
    }
    return count;
}

func d1p1Alg(_ contents: String) -> Int {
    let trimmed = contents.trimmingCharacters(in: .whitespacesAndNewlines)
    let lines = trimmed.components(separatedBy: "\n")
    let nums = lines.map {Int($0)!}
    var count = 0
    for (x, y) in nums.adjacentPairs() {
        if y > x {
            count += 1
        }
    }
    return count
}

func d1p1Alg2(_ contents: String) -> Int {
    let trimmed = contents.trimmingCharacters(in: .whitespacesAndNewlines)
    let lines = trimmed.components(separatedBy: "\n")
    var count = 0
    for (x, y) in lines.adjacentPairs() {
        if Int(y)! > Int(x)! {
            count += 1
        }
    }
    return count
}

func d1p2(_ contents: String) -> Int {
    let trimmed = contents.trimmingCharacters(in: .whitespacesAndNewlines)
    let lines = trimmed.split(separator: "\n")
    let nums = lines.map {Int($0)!}
    var count = 0
    for (w1, w2) in nums.windows(ofCount: 3).adjacentPairs() {
        let x = w1.reduce(0, +)
        let y = w2.reduce(0, +)
        if y > x {
            count += 1
        }
    }
    return count
}

func d1p2Lazy(_ contents: String) -> Int {
    let nums = Array(contents
      .trimming(while: \.isWhitespace)
      .lazy
      .split(separator: "\n")
      .map {Int($0)!})
    var count = 0
    for (w1, w2) in nums.windows(ofCount: 3).adjacentPairs() {
        let x = w1.reduce(0, +)
        let y = w2.reduce(0, +)
        if y > x {
            count += 1
        }
    }
    return count
}


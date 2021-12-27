func d3p1(_ contents: String) -> Int {
    var a: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    for num in contents.lazy.split(separator: "\n") {
        for (pos, bit) in num.enumerated() {
            if bit == "1" {
                a[pos] = a[pos] + 1
            } else {
                a[pos] = a[pos] - 1
            }
        }
    }
    var gamma = 0
    var epsilon = 0
    for bitCount in a {
        gamma <<= 1
        epsilon <<= 1
        if bitCount > 0 {
            gamma |= 1
        } else {
            epsilon |= 1
        }
    }
    return gamma * epsilon
}

func d3p2(_ contents: String) -> Int {
    let lines = contents.split(separator: "\n")
    var oxygenRatings = lines
    for i in 0..<12 {
        if oxygenRatings.count == 1 {
            break
        }
        var count = 0
        for line in oxygenRatings {
            if line[line.index(line.startIndex, offsetBy: i)] == "1" {
                count += 1
            } else {
                count -= 1
            }
        }
        if count >= 0 {
            oxygenRatings = oxygenRatings.filter { line in
                line[line.index(line.startIndex, offsetBy: i)] == "1"
            }
        } else {
            oxygenRatings = oxygenRatings.filter { line in
                line[line.index(line.startIndex, offsetBy: i)] == "0"
            }
        }
    }
    let oxygenRating = oxygenRatings[0]
    
    var co2Ratings = lines
    for i in 0..<12 {
        if co2Ratings.count == 1 {
            break
        }
        var count = 0
        for line in co2Ratings {
            if line[line.index(line.startIndex, offsetBy: i)] == "1" {
                count += 1
            } else {
                count -= 1
            }
        }
        if count < 0 {
            co2Ratings = co2Ratings.filter { line in
                line[line.index(line.startIndex, offsetBy: i)] == "1"
            }
        } else {
            co2Ratings = co2Ratings.filter { line in
                line[line.index(line.startIndex, offsetBy: i)] == "0"
            }
        }
    }
    let co2Rating = co2Ratings[0]
    return Int(oxygenRating, radix: 2)! * Int(co2Rating, radix: 2)!
}

func d3p2Parallel(_ contents: String) async -> Int {
    let lines = contents.split(separator: "\n")
    
    let oxygenRatingTask =  Task { () -> Int in
        var oxygenRatings = lines
        for i in 0..<12 {
            if oxygenRatings.count == 1 {
                break
            }
            var count = 0
            for line in oxygenRatings {
                if line[line.index(line.startIndex, offsetBy: i)] == "1" {
                    count += 1
                } else {
                    count -= 1
                }
            }
            if count >= 0 {
                oxygenRatings = oxygenRatings.filter { line in
                    line[line.index(line.startIndex, offsetBy: i)] == "1"
                }
            } else {
                oxygenRatings = oxygenRatings.filter { line in
                    line[line.index(line.startIndex, offsetBy: i)] == "0"
                }
            }
        }
        return Int(oxygenRatings[0], radix: 2)!
    }

    let co2RatingTask = Task { () -> Int in
        var co2Ratings = lines
        for i in 0..<12 {
            if co2Ratings.count == 1 {
                break
            }
            var count = 0
            for line in co2Ratings {
                if line[line.index(line.startIndex, offsetBy: i)] == "1" {
                    count += 1
                } else {
                    count -= 1
                }
            }
            if count < 0 {
                co2Ratings = co2Ratings.filter { line in
                    line[line.index(line.startIndex, offsetBy: i)] == "1"
                }
            } else {
                co2Ratings = co2Ratings.filter { line in
                    line[line.index(line.startIndex, offsetBy: i)] == "0"
                }
            }
        }
        return Int(co2Ratings[0], radix: 2)!
    }
    let ox = await oxygenRatingTask.value
    let co2 = await co2RatingTask.value
    return ox * co2
}

import Algorithms

func d2p1(_ contents: String) -> Int {
    var (horiz, depth) = (0, 0)
    for line in contents.lazy.split(separator: "\n") {
        let chunks = line.split(separator: " ")
        let direction = chunks[0]
        guard let value = Int(chunks[1]) else {
            print("Could not parse number with value \(chunks[1])")
            return 0
        }
        switch direction {
        case "forward":
            horiz += value
        case "down":
            depth += value
        case "up":
            depth -= value
        default:
            print("No match for \(direction)")
            return 0
        }
    }
    return horiz * depth
}

func d2p2(_ contents: String) -> Int {
    var (horiz, depth, aim) = (0, 0, 0)
    for line in contents.lazy.split(separator: "\n") {
        let chunks = line.split(separator: " ")
        let direction = chunks[0]
        guard let value = Int(chunks[1]) else {
            print("Could not parse number with value \(chunks[1])")
            return 0
        }
        switch direction {
        case "forward":
            horiz += value
            depth += value * aim
        case "down":
            aim += value
        case "up":
            aim -= value
        default:
            print("No match for \(direction)")
            return 0
        }
    }
    return horiz * depth
}

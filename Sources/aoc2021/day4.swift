import Algorithms

struct Board {
    var rows: [Int] = []

    init() {
        rows.reserveCapacity(25)
    }

    func checkWin(numbers: ArraySlice<Int>) -> Bool {
        outer: for i in 0..<5 {
            for j in 0..<5 {
                if !numbers.contains(rows[(i * 5) + j]) {
                    continue outer
                }
            }
            return true
        }
        outer: for i in 0..<5 {
            for j in 0..<5 {
                if !numbers.contains(rows[i + (j * 5)]) {
                    continue outer
                }
            }
            return true
        }
        return false
    }

    mutating func append(_ num: Int) {
        rows.append(num)
    }
}

struct Parser {
    var content: Substring

    mutating func run() throws -> ([Int], [Board]) {
        var numbers = [Int]()
        var boards = [Board]()
        var currentNumber = ""
        // Parse numbers
        outer: while let char = content.popFirst() {
            switch char {
            case ",":
                numbers.append(Int(currentNumber)!)
                currentNumber = ""
            case "\n":
                numbers.append(Int(currentNumber)!)
                break outer
            default:
                currentNumber.append(char)
            }
        }
        content.trimPrefix(while: \.isNewline)
        var currentBoard = Board()
        // Parse boards
        while let char = content.popFirst() {
            switch char {
            case " ":
                currentBoard.append(Int(currentNumber)!)
                currentNumber = ""
                content.trimPrefix(while: \.isWhitespace)
            case "\n":
                currentBoard.append(Int(currentNumber)!)
                currentNumber = ""
                if content.first == "\n" {
                    boards.append(currentBoard)
                    currentBoard = Board()
                    let _ = content.popFirst()
                }
                content.trimPrefix(while: \.isWhitespace)
            default:
                currentNumber.append(char)
            }
        }
        return (numbers, boards)
    }
}

// @TODO: Cleanup both parts below

func d4p1(_ contents: String) throws -> Int {
    var parser = Parser(content: contents[...])
    let (numbers, boards) = try parser.run()
    for i in 4..<numbers.count {
        let range = numbers[0...i]
        for board in boards {
            if board.checkWin(numbers: range) {
                var unchecked = 0
                for num in board.rows {
                    if !range.contains(num) {
                        unchecked += num
                    }
                }
                return unchecked * range[i]
            }
        }
    }
    return 0
}

func d4p2(_ contents: String) throws -> Int {
    var parser = Parser(content: contents[...])
    let (numbers, boards) = try parser.run()
    var winningBoards: Set<Int> = []
    for i in 4..<numbers.count {
        let range = numbers[0...i]
        for (index, board)in boards.enumerated() {
            if winningBoards.contains(index) {
                continue
            }
            if board.checkWin(numbers: range) {
                winningBoards.insert(index)
            }
            if winningBoards.count == boards.count {
                var unchecked = 0
                for num in board.rows {
                    if !range.contains(num) {
                        unchecked += num
                    }
                }
                return unchecked * range[i]
            }
        }
    }
    return 0
}
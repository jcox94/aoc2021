import Algorithms

struct Board {
    var rows: [Int] = []

    init() {
        rows.reserveCapacity(25)
    }

    func checkWin(numbers: ArraySlice<Int>) -> Bool {
        //var found = false
        outer: for i in 0..<5 {
            for j in 0..<5 {
                if !numbers.contains(rows[(i * 5) + j]) {
                    continue outer
                }
            }
            return true
        }
        outer2: for i in 0..<5 {
            for j in 0..<5 {
                if !numbers.contains(rows[i + (j * 5)]) {
                    continue outer2
                }
            }
            return true
        }
        return false
    }
}

func peek(with iter: String.Iterator) -> Character {
    var other = iter
    return other.next()!
}

class Parser {
    var content: String

    enum ParseError: Error {
        case InvalidCharacter
    }

    init(_ content: String) {
        self.content = content
    }

    func run() throws -> ([Int], [Board]) {
        var numbers: [Int] = []
        var boards: [Board] = []
        var parsingBoards = false
        var newLine = false
        var inNumber = false
        var currentNumber: Int = 0
        var currentBoard = Board()
        //parse numbers
        outer: for char in content {
            if !parsingBoards {
                switch char {
                case "\n":
                    numbers.append(currentNumber)
                    currentNumber = 0
                    parsingBoards = true
                case ",":
                    numbers.append(currentNumber)
                    currentNumber = 0
                default:
                    guard char.isWholeNumber else {
                        print("Got char of \(char)")
                        throw ParseError.InvalidCharacter
                    }
                    currentNumber *= 10
                    currentNumber += char.wholeNumberValue!
                }
            } else {
                switch char {
                case "\n":
                    if !inNumber && currentBoard.rows.count > 0 {
                        boards.append(currentBoard)
                        currentBoard = Board()
                        newLine = false
                    } else {
                        currentBoard.rows.append(currentNumber)
                        currentNumber = 0
                        inNumber = false
                        newLine = true
                    }
                    
                case " ":
                    if inNumber {
                        currentBoard.rows.append(currentNumber)
                        currentNumber = 0
                        inNumber = false
                    } else {
                        continue
                    }
                default:
                    guard char.isWholeNumber else {
                        print("Got char of \(char)")
                        throw ParseError.InvalidCharacter
                    }
                    inNumber = true
                    currentNumber *= 10
                    currentNumber += char.wholeNumberValue!
                    //newLine = false
                }
            }
        }
        boards.append(currentBoard)
        return (numbers, boards)

    // func run2() throws -> ([Int], [Board]) {
    //     var numbers = [Int]()
    //     var boards = [Board]()
    //     var partial: String = ""
    //     outer: for char in content {
    //         switch char {
    //         case "\n":
    //             numbers.append(Int(partial)!)
    //             partial = ""
    //             break outer
    //         case ",":
    //             numbers.append(Int(partial)!)
    //             partial = ""
    //         default:
    //             guard char.isWholeNumber else {
    //                 print("Got char of \(char)")
    //                 throw ParseError.InvalidCharacter
    //             }
    //             partial.append(char)
    //         }
    //     }
    //     return (numbers, boards)
    }
}

func d4p1(_ contents: String) throws -> Int {
    let parser = Parser(contents)
    let (numbers, boards) = try parser.run()
    for i in 4..<numbers.count {
        let range = numbers[0...i]
        for board in boards {
            if board.checkWin(numbers: range) {
                print(range)
                print(board)
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
    let parser = Parser(contents)
    let (numbers, boards) = try parser.run()
    var lastWinningBoard = boards[0]
    var lastRange: ArraySlice<Int> = []
    var winningBoards: Set<Int> = []
    var boardsLeft = 25
    for i in 4..<numbers.count {
        let range = numbers[0...i]
        for (index, board)in boards.enumerated() {
            if winningBoards.contains(index) {
                continue
            }
            if board.checkWin(numbers: range) {
                boardsLeft -= 1
                winningBoards.insert(index)
            }
            if boardsLeft == 0 {
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

func d4p2Alt(_ contents: String) throws -> Int {
    let parser = Parser(contents)
    let (numbers, boards) = try parser.run()
    for i in 4..<numbers.count {
        let range = numbers[0...i]
        for board in boards {
            if board.checkWin(numbers: range) {
                print(range)
                print(board)
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
import Foundation

@main
struct AOC {
    static func main() throws {
        let contents = try String(contentsOfFile: "files/day4.txt")
        let solution = try d4p2(contents)
        print(solution)
    }
}

import Foundation

@main
struct AOC {
    static func main() throws {
        let contents = try String(contentsOfFile: "files/day4.txt", encoding: .utf8)
        let solution = try d4p1(contents)
        print(solution)
    }
}

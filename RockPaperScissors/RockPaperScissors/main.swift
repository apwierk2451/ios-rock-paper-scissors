//
//  RockPaperScissors - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

var shouldContinue: Bool = true

let validSelection: Set<Int> = [0, 1, 2, 3]

enum Sign: Int {
    case rock = 1
    case scissors = 2
    case paper = 3
}

enum InputError: Error {
    case invalidInput
}

var computerSign: Sign = .paper
var playerSign: Sign = .paper

func printStartMessage() {
    print("가위(1), 바위(2), 보(3)! <종료: 0> : ", terminator: "")
}

func generateComputerSign() {
    let indexOfSign: Int = Int.random(in: 1...3)
    guard let computer = Sign(rawValue: indexOfSign) else {
        return
    }
    computerSign = computer
}

func receivePlayerInput() -> String {
    let playerInput = readLine() ?? ""
    return playerInput
}

func convertToInt(from input: String) throws -> Int {
    guard let convertedInput = Int(input), convertedInput <= 3 && convertedInput >= 0 else {
        throw InputError.invalidInput
    }
    return convertedInput
}

func getValidInput(input: String) -> Int {
    var inputNumber = 4
    do {
        let validInput = try convertToInt(from: input)
        inputNumber = validInput
    } catch InputError.invalidInput {
        print("잘못된 입력입니다.다시 시도해주세요.")
    } catch {
        print(error)
    }
    return inputNumber
}

func inputFromPlayer() -> Int {
    var isValidInput: Bool = false
    var playerInput: Int
    repeat {
        printStartMessage()
        let input = receivePlayerInput()
        playerInput = getValidInput(input: input)
        isValidInput = validSelection.contains(playerInput)
    } while !isValidInput
    return playerInput
}

func generatePlayerSign(input: Int) {
    let indexOfSign: Int = input
    guard let player = Sign(rawValue: indexOfSign) else {
        return
    }
    playerSign = player
}

func compareWhenScissors() {
    switch playerSign {
    case .paper:
        print("졌습니다!")
    case .rock:
        print("이겼습니다!")
    case .scissors:
        print("비겼습니다!")
    }
}

func compareWhenRock() {
    switch playerSign {
    case .paper:
        print("이겼습니다!")
    case .rock:
        print("비겼습니다!")
    case .scissors:
        print("졌습니다!")
    }
}

func compareWhenPaper() {
    switch playerSign {
    case .paper:
        print("비겼습니다!")
    case .rock:
        print("졌습니다!")
    case .scissors:
        print("이겼습니다!")
    }
}

func judgeWinner() {
    switch computerSign {
    case .paper:
        compareWhenPaper()
    case .scissors:
        compareWhenScissors()
    case .rock:
        compareWhenRock()
    }
}

func playGameOnce(input: Int) {
    guard input != 0 else {
        shouldContinue = false
        return
    }
    generateComputerSign()
    generatePlayerSign(input: input)
    judgeWinner()
}

func exitGameWithWinner() {
    if computerSign != playerSign {
        shouldContinue = false
    }
}

func playGame() {
    repeat {
        let playerInput = inputFromPlayer()
        playGameOnce(input: playerInput)
        exitGameWithWinner()
    } while shouldContinue
}

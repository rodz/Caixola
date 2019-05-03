//
//  GameMatch.swift
//  ForCaBanana
//
//  Created by student on 26/04/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation


class GameMatch{
    
    var Word: String
    var Remaining: Int
    var Accepted: [Character]
    var Failure: [Character]
    var Lifes: Int
    var Image: String
    
    init(word: String, link: String){
    
        self.Word = word
        self.Accepted = []
        self.Failure = []
        self.Lifes = 6
        self.Image = link
        self.Remaining = Set(self.Word.characters).count
    }
    
    func alreadySelected(letter: Character) -> Bool{
        return self.Accepted.contains(letter) || self.Failure.contains(letter)
    }
    func putNewLetter(atual: String, letra: Character) -> String{
        var resp :String = ""
        var count: Int = 0
        while count<Word.characters.count {
            if self.Word[count].characters.first == letra{
                resp.characters.append(letra)
            }else{
                resp.characters.append(atual[count+count].characters.first!)
            }
            resp.characters.append(" ")
            count = count+1
        }
        return resp
    }
    
    func getInicialString() -> String{
        var resp :String = ""
        var count: Int = 0
        while count<Word.characters.count {
            resp.characters.append("_")
            resp.characters.append(" ")
            count = count+1
        }
        return resp
    }
    
    func isLetter(letter: Character) -> Bool{
        return self.Word.characters.contains(letter)
    }
    
    func isGameOver() -> Bool{
        return self.Remaining <= 0 || self.Lifes <= 0
    }
    
    func addLetter(letter: Character){
        if !alreadySelected(letter: letter){
            if isLetter(letter: letter){
                self.Accepted.append(letter)
                self.Remaining = self.Remaining - 1
            }else{
                self.Failure.append(letter)
                self.Lifes = self.Lifes - 1
            }
        }
    }
    
    
}

extension String {
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return self[start..<end]
    }
    
    subscript (r: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return self[start...end]
    }
}

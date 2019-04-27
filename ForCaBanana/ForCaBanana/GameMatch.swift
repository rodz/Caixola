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
    
    func isLetter(letter: Character) -> Bool{
        return self.Word.characters.contains(letter)
    }
    
    func isGameOver() -> Bool{
        return self.Remaining == 0 || self.Lifes == 0
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

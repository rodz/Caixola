//
//  ViewControllerGame.swift
//  ForCaBanana
//
//  Created by student on 26/04/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerGame: UIViewController {
    
    var idiom: String = "pt-BR"
    var level: Int = 1
    var Portuguese: [WordComp] = [WordComp.init(word: "banana", link: "3d542ec6f880b9ff7ce98baf35e0a8fa.jpg"), WordComp.init(word: "abelha", link: "956450_1.jpg"), WordComp.init(word: "bala", link: "how-to-draw-candy-step-9.jpg")]
    var English: [WordComp] = [WordComp.init(word: "banana", link: "3d542ec6f880b9ff7ce98baf35e0a8fa.jpg"), WordComp.init(word: "abelha", link: "956450_1.jpg"), WordComp.init(word: "bala", link: "how-to-draw-candy-step-9.jpg")]
    var Spanish: [WordComp] = [WordComp.init(word: "banana", link: "3d542ec6f880b9ff7ce98baf35e0a8fa.jpg"), WordComp.init(word: "abelha", link: "956450_1.jpg"), WordComp.init(word: "bala", link: "how-to-draw-candy-step-9.jpg")]
    var French: [WordComp] = [WordComp.init(word: "banana", link: "3d542ec6f880b9ff7ce98baf35e0a8fa.jpg"), WordComp.init(word: "abelha", link: "956450_1.jpg"), WordComp.init(word: "bala", link: "how-to-draw-candy-step-9.jpg")]
    var game: GameMatch = GameMatch.init(word: "oi", link: "3d542ec6f880b9ff7ce98baf35e0a8fa.jpg")
    
    @IBOutlet weak var workImage: UIImageView!
    @IBOutlet weak var acertosLabel: UILabel!
    @IBOutlet weak var errosLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(level)
        print(idiom)
        setUp(language: idiom, level: level)
        self.errosLabel.text = ""
        self.acertosLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    func setUp(language: String, level: Int){
        let random = Int(arc4random_uniform(6) + 1)
        var pala : WordComp
        if language == "pt-BR"{
            let random = Int(arc4random_uniform(UInt32(Portuguese.count)))
            pala = Portuguese[random]
        }else if language == "en-US"{
            let random = Int(arc4random_uniform(UInt32(English.count)))
            pala = English[random]
        }else if language == "es-MX"{
            let random = Int(arc4random_uniform(UInt32(Spanish.count)))
            pala = Spanish[random]
        }else {
            let random = Int(arc4random_uniform(UInt32(French.count)))
            pala = French[random]
        }
        
        if level == 2{
            self.voiceButtom.isHidden = true
        }
        
        
        game = GameMatch.init(word: pala.Word, link: pala.Image)
        self.workImage.image = UIImage(named: game.Image)
        self.acertosLabel.text = ""
        self.errosLabel.text = ""
        
    }

    /*
    @IBAction func enterLetterButtom(_ sender: Any) {
        
        self.addLetter(letter: (gameLetterTextField.text?.characters.first)!)
        self.gameLetterTextField.text = ""
        
    }
    
    @IBAction func entterWordButtom(_ sender: Any) {
        
        game = GameMatch.init(word: gameWordTextField.text!, link: "3d542ec6f880b9ff7ce98baf35e0a8fa.jpg")
        self.workImage.image = UIImage(named: game.Image)
        self.acertosLabel.text = ""
        self.errosLabel.text = ""
        
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addLetter(letter: Character){
        if game.isLetter(letter: letter){
            if !game.alreadySelected(letter: letter){
                self.acertosLabel.text = self.acertosLabel.text! + " " + String(letter)
            }
            game.addLetter(letter: letter)
        }else{
            if !game.alreadySelected(letter: letter){
                self.errosLabel.text = self.errosLabel.text! + " " + String(letter)
            }
            game.addLetter(letter: letter)
        }
        
    }
    @IBAction func enterLetter(_ sender: Any) {
        
    }
    @IBOutlet weak var voiceButtom: UIButton!
    @IBAction func voiceButtom(_ sender: Any) {
        TextToVoice(word: game.Word, lang: self.idiom)
    }
    
    func TextToVoice(word: String, lang: String){
        let utter = AVSpeechUtterance(string: word)
        utter.voice = AVSpeechSynthesisVoice(language: lang)
        let voice = AVSpeechSynthesizer()
        voice.speak(utter)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

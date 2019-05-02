//
//  ViewControllerTutorial1.swift
//  ForCaBanana
//
//  Created by student on 02/05/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerTutorial1: UIViewController {
    var leng: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if leng == "pt-BR"{
            self.textLabel.text = "Coloque a letra dentro da caixa e pressione o botão para fazer ela aparecer na tela. Tenta acertar quais letras estão faltando."
        }else if self.leng == "en-US"{
            self.textLabel.text = "Put the letter inside the box and press the button to make it appear on the screen. Try to guess which letters are missing."
        }else if self.leng == "es-MX"{
            self.textLabel.text = "Coloque la letra dentro de la caja y pulse el botón para que aparezca en la pantalla. Intenta acertar qué letras faltan."
        }else {
            self.textLabel.text = "Placez la lettre à l'intérieur de la boîte et appuyez sur le bouton pour la faire apparaître à l'écran. Essayez de deviner quelles lettres manquent."
        }
        TextToVoice(word: self.textLabel.text!, lang: self.leng)
        
    }
    @IBOutlet weak var textLabel: UITextView!
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func TextToVoice(word: String, lang: String){
        let utter = AVSpeechUtterance(string: word)
        utter.voice = AVSpeechSynthesisVoice(language: lang)
        let voice = AVSpeechSynthesizer()
        voice.speak(utter)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let novaView = segue.destination as? ViewControllerTutorial2{
            novaView.leng = self.leng
        }
        if let novaView = segue.destination as? ViewControllerSelector{
            novaView.leng = self.leng
        }
        
    }


}

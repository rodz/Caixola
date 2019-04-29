//
//  ViewControllerHome.swift
//  ForCaBanana
//
//  Created by student on 25/04/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class ViewControllerHome: UIViewController {
    var leng: String = "pt-BR"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var portugueseButtom: UIButton!
    @IBAction func portugueseButtom(_ sender: Any) {
        self.leng = "pt-BR"
    }
    @IBOutlet weak var englishButtom: UIButton!
    @IBAction func englishButtom(_ sender: Any) {
        self.leng = "en-US"
    }
    @IBOutlet weak var frenchButtom: UIButton!
    @IBAction func frenchButtom(_ sender: Any) {
        self.leng = "fr-FR"
    }
    @IBOutlet weak var EspButtom: UIButton!
    @IBAction func EspButtom(_ sender: Any) {
        self.leng = "es-MX"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let novaView = segue.destination as? ViewControllerSelector{
            //novaView.corLabel.text = corTextField.text
            novaView.leng = self.leng
            
        }

    }

}

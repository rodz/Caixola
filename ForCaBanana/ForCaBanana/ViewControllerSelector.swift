//
//  ViewControllerSelector.swift
//  ForCaBanana
//
//  Created by student on 25/04/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class ViewControllerSelector: UIViewController {

    var leng: String = ""
    var level: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.leng)
        // Do any additional setup after loading the view.
    }

    @IBAction func level3(_ sender: Any) {
        self.level = 3
    }
    @IBAction func level2(_ sender: Any) {
        self.level = 2
    }
    @IBAction func level1(_ sender: Any) {
        self.level = 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let novaView = segue.destination as? ViewControllerGame{
                //novaView.corLabel.text = corTextField.text
            novaView.level = self.level
            novaView.idiom = self.leng
                
        }
        if let novaView = segue.destination as? ViewControllerTutorial1{
            novaView.leng = self.leng
        }
        
    }
    

}

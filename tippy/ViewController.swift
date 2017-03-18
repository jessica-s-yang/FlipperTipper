//
//  ViewController.swift
//  tippy
//
//  Created by Jessica Yang on 3/3/17.
//  Copyright © 2017 Jessica Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // naming conventions - descriptionType
    // variables to be updated by
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet var firstView: UIView!
    
    var passedSettings:Int!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue){
        
    }

    
    @IBAction func onTap(_ sender: Any) {
        print("scene 1: onTap")
        //when you tap, it'll dismiss keyboard
        view.endEditing(true)
    }
    
    
    //load the tip percentage from NSUserDefaults whenever the view appears.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view, typically from a nib.
        print("scene 1: view will appear")
        if passedSettings == nil {
            print("no settings were passed")
            passedSettings = 0
            
        }else{
            tipControl.selectedSegmentIndex = passedSettings
             print("settings passed")
        }
    }
    
    //set textfield through UI interface, decimal pad keyboard
    //events for textfield, update tip value each time textfield content changes
    //AnyObject to specify action coming from UIButton
    @IBAction func calculateTip(_ sender: AnyObject) {
        //let - var you don't need to change value of later
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0 //if it is wrong, default turns it to 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        // special formating with 2 decimal places
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    

}


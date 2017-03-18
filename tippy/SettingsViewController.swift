//
//  SettingsViewController.swift
//  tippy
//
//  Created by Jessica Yang on 3/12/17.
//  Copyright © 2017 Jessica Yang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var tipDefault: UISegmentedControl!
    var data: [Int] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("scene 2: view did load")
        // Do any additional setup after loading the view.
        navigationController?.delegate = self
        data = [tipDefault.selectedSegmentIndex]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     //load the tip percentage from NSUserDefaults whenever the view appears.
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("scene 2: view will appear")
     
        let defaults = UserDefaults.standard
        if let savedSegmentedIndex = defaults.value(forKey: "index"){
            tipDefault.selectedSegmentIndex = savedSegmentedIndex as! Int
            print("scene 2: saved Segment Index")
        }
     }
    
    
    
    //send data over to other screne
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("scene 2: view will disappear")
    }
    

    // does everything you want prior to segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToMenu"{
            print("scene 2: prepare for seque")
            //safety parameter to prevent crash
            if let destination_vc1 = segue.destination as? ViewController {
                destination_vc1.passedSettings = sender as? Int
                print("Sender Value: \(sender)")
            
            }
        }
    }
    
    
        
    @IBAction func onSave(_ sender: AnyObject) {
        
        let alert = UIAlertController(title: "Hi there!", message: "Enjoy tipping!", preferredStyle: .alert)
        let SaveAction = UIAlertAction(title: "saved", style: UIAlertActionStyle.default, handler: {
            (_)in
        })
        
        alert.addAction(SaveAction)
        self.present(alert, animated: true, completion: nil)
        
        let selectedSettings = tipDefault.selectedSegmentIndex
        performSegue(withIdentifier: "unwindToMenu", sender: selectedSettings) //switches scene and sends info
    }
    
    //Save settings with NSuser
    @IBAction func onSelect(_ sender: UISegmentedControl) {
        print("scene 2: segment selected")
        let defaults = UserDefaults.standard //constant not being modified
        defaults.set(tipDefault.selectedSegmentIndex, forKey: "index")
        defaults.synchronize()
        print("scene 2: synchronized")
    }

}

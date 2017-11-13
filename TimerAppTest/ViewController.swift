//
//  ViewController.swift
//  TimerAppTest
//
//  Created by Daniel Suskevic on 13/11/2017.
//  Copyright © 2017 Daniel Suskevic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var timer = Timer()
    var number : Int = 0
    var state : Bool = true
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pause() {
        timer.invalidate()
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        if state == false {
            state = true
            sTimer()
        } else if state == true {
            state = false
            pause()
        }
    }
    
    // Mark: Timers
    
    func sTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        check()
        if state == true {
        number -= 1
        label.text = String(number)
        }
    }
    
    func check() {
        if number < 1 {
            timer.invalidate()
            state = false
        }
    }
    
    //MARK: Text Field Delegate Methods

    func textFieldDidEndEditing(_ textField: UITextField) {
        label.text = inputTextField.text
        if let a = Int(inputTextField.text!) {
            number = a
        }
        print("hoooli", textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


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
    var date = Date()
    var result1 : [Int] = []
    var result2 : [Int] = []
    var globalH : Int? = nil
    var globalM : Int? = nil
    var globalS : Int? = nil
    
    @IBOutlet weak var timerWarningLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var dateTimeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timerWarningLabel.isHidden = true
        inputTextField.placeholder = "0000"
        dateTimeTextField.placeholder = "00:00:00"
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
    
    func checkIfNumber(data: UITextField) -> Bool {
        let possibleNumber = data.text
        let convertedNumber = Int(possibleNumber!)
        if convertedNumber != nil {
            timerWarningLabel.isHidden = true
            return true
        }
        timerWarningLabel.isHidden = false
        return false
    }
    
    func convertDateTime(text: String) -> [Int] {
        guard let text = dateTimeTextField.text, (0..<9).contains(text.count) else {
            return []
        } //escaping empty UITextField and the length
        let splitText = text.split(separator: ":")
        var timeArray : [Int] = []
        let values = text.split(separator: ":")
        guard values.count == 3 else {
            return []
        }
        for item in splitText {
            if let a = Int(item) {
                timeArray.append(a)
            }
        }
        return timeArray
    }
 
    func getTodayString() -> String? {
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        /*
        let year = components.year
        let month = components.month
        let day = components.day */
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        //  let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        let today_string = String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
        
    }
    
    //MARK: Text Field Delegate Methods
    
    /*  func textFieldDidEndEditing(_ textField: UITextField) {
     label.text = inputTextField.text
     if let a = Int(inputTextField.text!) {
     number = a
     }
     print("hoooli", textField)
     }
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     textField.resignFirstResponder()
     
     return true
     } */
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
        let state : Bool = checkIfNumber(data: inputTextField)
        if state == true {
            label.text = inputTextField.text
            if let a = Int(inputTextField.text!) {
                number = a
            }
        }
        if let a = dateTimeTextField.text {
            result1 = convertDateTime(text: a)
            if result1.count == 3 {
                globalH = result1[0]
                globalM = result1[1]
                globalS = result1[2]
            }
            //let b = getTodayString()
            //result2 = convertDateTime(text: getTodayString())
            
        }
        if let a = getTodayString() {
            print(a)
            result2 = convertDateTime(text: a)
        }
        print(result1, result2)
        print(result1)
        print(result2)
        //print(getTodayString())
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        dateTimeTextField.text = ""
        inputTextField.text = ""
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
    
}


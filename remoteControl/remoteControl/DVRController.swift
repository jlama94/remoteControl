//
//  DVRController.swift
//  remoteControl
//
//  Created by Julio on 2/19/19.
//  Copyright © 2019 Julio Lama. All rights reserved.
//

import UIKit
// TODO: Change disable logic for buttons.
class DVRController: UIViewController {

    @IBOutlet weak var dvrPowerState: UILabel!
    
    
    @IBOutlet weak var dvrOnOffState: UILabel!
    
    
    @IBOutlet var dvrButtons: [UIButton]!
    
    
    @IBOutlet weak var dvrCtrlState: UILabel!
    
    
    @IBOutlet weak var onOffButton: UISwitch!
    
    // Enum for DVR control states.
    enum DvrControlStates: String, CaseIterable {
        case Off = ""
        case Stopped = "Stopped"
        case Playing = "Playing"
        case Paused = "Paused"
        case FastForwarding = "Fast Forwarding"
        case FastRewinding = "Fast rewinding"
        case Recording = "Recording"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onOffButton.isOn = false
        self.dvrOnOffState.text = "Off"
        enableOrDisableButtons(dvrButtons, onOffButton)
    }
    
    /*
        Segue to go back to the TV controller.
    */
    @IBAction func switchToTV(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    
    /*
        On/Off action button.
    */
    @IBAction func dvrOnOffBtnAction(_ sender: UISwitch) {
        if sender.isOn {
           dvrOnOffState.text = "On"
            dvrCtrlState.text = DvrControlStates.Stopped.rawValue
            enableOrDisableButtons(dvrButtons, sender)
        }
        else {
            dvrOnOffState.text = "Off"
            dvrCtrlState.text = DvrControlStates.Off.rawValue
            enableOrDisableButtons(dvrButtons, sender)
        }
    }
    
    /*
        Disables all buttons when the power is "Off".
    */
    private func enableOrDisableButtons(_ buttons: [UIButton], _ dvrState: UISwitch) -> Void {
        if !dvrState.isOn {
            for button in buttons {
                let currentBtn = button
                if currentBtn.isEnabled {
                    currentBtn.isEnabled = false
                }
            }
        }
        else if dvrState.isOn {
            for button in buttons {
                let currentBtn = button
                if !currentBtn.isEnabled {
                    currentBtn.isEnabled = true
                }
            }
        }
    }
    
    
    /*
        Alerts that the DVR controler is off.
    */
    private func generalAlertMessage(message: String) -> Void {
        let alertCtrl: UIAlertController = UIAlertController()
        let message = message
        
        let alertAction: UIAlertAction = UIAlertAction(title: message, style: .default, handler: nil)
        
        alertCtrl.addAction(alertAction)
        present(alertCtrl, animated: true, completion: nil)
    }
    
    
    /*
     Gives the action to change state.
    */
    private func changeCurrentState(button: UIButton)-> Void {
        let title = "Change Current State?"
        let message = "You have selected state: \(button.currentTitle!)"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel Current DVR State", style: .destructive, handler: nil)
        
        // get the button
        let button = getButton(button.currentTitle!, buttons: dvrButtons)
        
        let okayAction = UIAlertAction(title: "Proceed to \(button.currentTitle!)", style: .default, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    

    /*
     Gets a button from the buttons collection.
    */
    private func getButton(_ buttonName: String,
                           buttons: [UIButton]) -> UIButton {
        var result: UIButton? = nil
        for button in buttons {
            if button.currentTitle == buttonName {
                result = button
                break
            }
        }
        return result!
    }
    
    
    /*
        Stop button action.
    */
    @IBAction func stop(_ sender: UIButton) {
        dvrCtrlState.text = DvrControlStates.Stopped.rawValue
    }
    
    
    
    /*
        The record button action.
    */
    @IBAction func record(_ sender: UIButton) {
        if dvrCtrlState.text != "Stopped" {
            dvrCtrlState.text = DvrControlStates.Off.rawValue
            changeCurrentState(button: sender)
            return
        }
        else if dvrCtrlState.text == "Stopped" {
            dvrCtrlState.text = DvrControlStates.Recording.rawValue
        }
    }
    
    
    @IBAction func play(_ sender: UIButton) {
        if self.dvrCtrlState.text == "Recording" {
            changeCurrentState(button: sender)
        }
        else {
            self.dvrCtrlState.text = DvrControlStates.Playing.rawValue
        }
    }
    
    @IBAction func pause(_ sender: UIButton) {
        if self.dvrCtrlState.text == "Recording" {
            changeCurrentState(button: sender)
        }
        else {
            self.dvrCtrlState.text = DvrControlStates.Paused.rawValue
        }
    }
    
    @IBAction func fastForwarding(_ sender: UIButton) {
        if self.dvrCtrlState.text == "Recording" {
            changeCurrentState(button: sender)
        }
        else {
            self.dvrCtrlState.text = DvrControlStates.FastForwarding.rawValue
        }
    }
    
    @IBAction func fastRewinding(_ sender: UIButton) {
        if self.dvrCtrlState.text == "Recording" {
            changeCurrentState(button: sender)
        }
        else {
            self.dvrCtrlState.text = DvrControlStates.FastRewinding.rawValue
        }
    }
}

//
//  JoystickViewController.swift
//  Robot-Test
//
//  Created by TUNGYING-CHAO on 8/12/15.
//  Copyright © 2015 TUNGYING-CHAO. All rights reserved.
//

import UIKit

class JoystickViewController: UIViewController {

//    var myRobotLE: RKRobotLE?
//    var myOllie: RKOllie!
    var ollieDeviceManager : OllieDeviceManager!
    var isConnected : Bool = false
    
    @IBAction func moveRight(sender: UIButton) {
        if self.isConnected {
            print("right")
            self.ollieDeviceManager.moveRight(90, velocity: 0.5)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appWillResignActive:", name: UIApplicationWillResignActiveNotification, object: nil)
        // Do any additional setup after loading the view.
        
        self.isConnected = self.ollieDeviceManager.connectToTheOllie()
        print("Joystick is connected: \(self.isConnected)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    
    func appWillResignActive(note: NSNotification){
        self.ollieDeviceManager.disconnect()
    }
}

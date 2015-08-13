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
    var myOllie: RKOllie!
    var ollieDeviceManager : OllieDeviceManager!
    var isConnected : Bool = false
    
    @IBAction func moveRight(sender: UIButton) {
        if self.myOllie != nil {
            print("right")
//            self.ollieDeviceManager.moveRight(90, velocity: 0.5)
            self.myOllie.driveWithHeading(90, andVelocity: 0.5)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appWillResignActive:", name: UIApplicationWillResignActiveNotification, object: nil)
        // Do any additional setup after loading the view.
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleRobotStateChangeNotification", name: kRobotDidChangeStateNotification, object: nil)
//        RKRobotDiscoveryAgent.sharedAgent().addNotificationObserver(self, selector: "handleRobotStateChangeNotification")
        self.isConnected = self.ollieDeviceManager.connectToTheOllie()
        if self.isConnected {
            self.ollieDeviceManager.stopDiscovery()
        }
//        self.myOllie = RKOllie(robot: self.ollieDeviceManager.ollieBLE)
        RKRobotDiscoveryAgentLE.connect(self.ollieDeviceManager.ollie.robot)
        self.myOllie = self.ollieDeviceManager.ollie
        print("Joystick is connected: \(self.myOllie.robot.isOnline())")
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
    
    func handleRobotStateChangeNotification(notification: RKRobotChangedStateNotification){
        print("haah")
        switch(notification.type){
        case .Online:
            print("Online")
            break
        case .Disconnected:
            print("Disconnected")
            break
        case .Offline:
            print("Offline")
            break
        case .Connecting:
            print("Connecting")
            break
        default:
            break
        }
    }
}

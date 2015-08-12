//
//  ViewController.swift
//  Robot-Test
//
//  Created by TUNGYING-CHAO on 8/12/15.
//  Copyright © 2015 TUNGYING-CHAO. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
//    let kRobotIsAvailableNotification : String = "available"
    var robot: RKConvenienceRobot!
    var myerror: NSError?
    var ledOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appWillResignActive:", name: UIApplicationWillResignActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appDidBecomeActive:", name: UIApplicationDidBecomeActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleAvailable:", name: kRobotIsAvailableNotification, object: nil)
//        RKRobotDiscoveryAgent.sharedAgent().addNotificationObserver(self, selector: "handleRobotStateChangeNotification:")
        RKRobotDiscoveryAgentLE.sharedAgent().stopDiscovery()
        
        RKRobotDiscoveryAgentLE.sharedAgent().connectStrategy = 
        
        let state = RKRobotDiscoveryAgentLE.sharedAgent().startDiscoveryAndReturnError(&myerror)
        
        if !state {
             println("Error : \(error!)")
        }
        
        
//        RKRobotDiscoveryAgentLE.sharedAgent().stopDiscovery()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func appWillResignActive(note: NSNotification) {
        RKRobotDiscoveryAgent.disconnectAll()
        stopDiscovery()
    }
    
    func appDidBecomeActive(note: NSNotification){
        print("start discovering")
        RKRobotDiscoveryAgentLE.sharedAgent().startDiscovery()
    }
    
    func handleRobotStateChangeNotification(notification: RKRobotChangedStateNotification){
        print("handleRobotState")
        let noteRobot = notification.robot
        
        switch(notification.type){
            case .Connecting:
                break
            case .Online:
                if(noteRobot.isKindOfClass(RKRobotLE)){
                        print("work")
                        self.robot = RKOllie(robot: noteRobot)
                }else {
                        print("Weird")
                }
                break
            case .Disconnected:
                startDiscovery()
                break
            default:
                break
        }
    }
    
    func disconnectRobot(){
        self.robot.disconnect()
    }
    
    func startDiscovery(){
        RKRobotDiscoveryAgent.startDiscovery()
    }
    
    func stopDiscovery(){
        RKRobotDiscoveryAgent.stopDiscovery()
    }
    
    func handleAvailable(note: RKRobotAvailableNotification){
        print(note.robots.count)
//        print(note.robots[0].name)
    }

}


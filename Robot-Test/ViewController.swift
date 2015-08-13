//
//  ViewController.swift
//  Robot-Test
//
//  Created by TUNGYING-CHAO on 8/12/15.
//  Copyright © 2015 TUNGYING-CHAO. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
//    var robot: RKRobotLE!
//    var myerror: NSError?
//    var ledOn = false
//    var robotList = [RKRobotLE]()
//    var robotCellIdentifier: String = "robotCell"
    var ollieDeviceManager : OllieDeviceManager = OllieDeviceManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleAvailable:", name: kRobotIsAvailableNotification, object: nil)
        self.ollieDeviceManager.startDiscovery()
        tableView.dataSource = self.ollieDeviceManager
        tableView.delegate = self.ollieDeviceManager
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
    
    func disconnectRobot(){
        self.ollieDeviceManager.disconnect()
    }
    
    
    func stopDiscovery(){
        self.ollieDeviceManager.stopDiscovery()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "handleAvailable", object: nil)
    }
    
    func handleAvailable(note: RKRobotAvailableNotification){
        print(note.robots.count)
        if self.ollieDeviceManager.deviceList.count != note.robots.count {
            for bot in note.robots {
                if !self.ollieDeviceManager.deviceList.contains(bot as! RKRobotLE) {
                    self.ollieDeviceManager.deviceList.append(bot as! RKRobotLE)
                }
            }
            tableView.reloadData()
        }
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier(robotCellIdentifier, forIndexPath: indexPath) as UITableViewCell
//        
//        let row = indexPath.row
//        cell.textLabel?.text = robotList[row].name()
//        
//        return cell
//    }
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return robotList.count
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "robotConnectSegue" {
            let destinationVC = segue.destinationViewController as! JoystickViewController
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                self.ollieDeviceManager.setBLE(indexPath.row)
                destinationVC.ollieDeviceManager = self.ollieDeviceManager
//                destinationVC.myRobotLE = robotList[indexPath.row]
                print("next view")
                stopDiscovery()
            }
            
        }
        
    }


}


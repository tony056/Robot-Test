//
//  OllieDeviceManager.swift
//  Robot-Test
//
//  Created by TUNGYING-CHAO on 8/13/15.
//  Copyright © 2015 TUNGYING-CHAO. All rights reserved.
//

import UIKit

class OllieDeviceManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    var ollieBLE : RKRobotLE?
    var ollie : RKOllie!
    var deviceList = [RKRobotLE]()
    var robotCellIdentifier: String = "robotCell"
    
    
    override init() {
        super.init()
    }
    
    
    func startDiscovery(){
        RKRobotDiscoveryAgentLE.sharedAgent().stopDiscovery()
        RKRobotDiscoveryAgentLE.sharedAgent().connectStrategy = RKNoConnectStrategy()
        RKRobotDiscoveryAgentLE.sharedAgent().startDiscovery()
    }
    
    func stopDiscovery(){
        RKRobotDiscoveryAgentLE.sharedAgent().stopDiscovery()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(robotCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = deviceList[row].name()
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList.count
    }
    
    func disconnect(){
        self.ollie.disconnect()
    }
    
    func setBLE(index: Int){
        self.ollieBLE = self.deviceList[index]
    }
    
    func connectToTheOllie() -> Bool {
        if self.ollieBLE == nil {
            return false
        }
        
        self.ollie = RKOllie(robot: self.ollieBLE)
        RKRobotDiscoveryAgent.connect(self.ollie.robot)
        print(self.ollie.isConnected())
        return self.ollie.isConnected()
    }
    
    func moveRight(heading: Float, velocity: Float) {
        self.ollie.driveWithHeading(90, andVelocity: velocity)
    }
    
}

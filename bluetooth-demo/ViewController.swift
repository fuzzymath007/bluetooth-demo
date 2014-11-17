//
//  ViewController.swift
//  bluetooth-demo
//
//  Created by Matthew Chess on 11/16/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    @IBAction func startSearching(sender: AnyObject) {
        
        if(bluetoothOn == true){
            startScan()
        }
        
    }
    @IBAction func devicesOrServices(sender: AnyObject) {
    }
    @IBOutlet var numberOfDevicesLabel: UILabel!
    @IBOutlet var devicesLog: UITextView!
    var bluetoothOn: Bool = false
    
    var centralManager:CBCentralManager!
    
    var discoveredPeripheral:CBPeripheral!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startUpCentralManager()
        
        
    }
    
    func startUpCentralManager(){
        let startupMessage = "\n Initializing central manager \n"
        
        println(startupMessage)
        
        devicesLog.text = devicesLog.text .stringByAppendingString(startupMessage)
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    func startScan(){
        let startScanMeassge = "\n Discovering Devices \n"
        
        println(startScanMeassge)
        
        devicesLog.text = devicesLog.text .stringByAppendingString(startScanMeassge)
        
        var setting = [CBCentralManagerScanOptionAllowDuplicatesKey:false]
        
        centralManager!.scanForPeripheralsWithServices(nil, options: setting)
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        println("\n Found IT! \n")
        
        println(peripheral.name)
        
        discoveredPeripheral = peripheral
        
        centralManager.connectPeripheral(peripheral, options: nil)
        
        devicesLog.text = devicesLog.text .stringByAppendingString(peripheral.name)
        
        
    }
    
//    func peripheral(peripheral: CBPeripheral!, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
//
//    }

    func centralManagerDidUpdateState(central: CBCentralManager!) {
        println("\n CHecking State \n")
        
        switch(central.state){
        case .PoweredOff:
            println("\n Bluetooth is off \n")
            
        case .PoweredOn:
            bluetoothOn = true
            println("\n CoreBluetooth BLE hardware is running \n")
            devicesLog.text = devicesLog.text .stringByAppendingString("CoreBluetooth BLE hardware is running \n")
            
        case .Resetting:
            println("\n CoreBluetooth BLE hardware is resetting \n")
            
        case .Unauthorized:
            println("\n CoreBluetooth BLE state is unauthorized \n")
            
        case .Unknown:
            println("\n CoreBluetooth BLE state is unknown \n");
            
        case .Unsupported:
            println("\n CoreBluetooth BLE hardware is unsupported on this platform \n");
        }

        
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


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
        println("Initializing central manager")
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    func startScan(){
        println("Discovering Devices")
        
        self.centralManager.scanForPeripheralsWithServices(nil, options:[CBCentralManagerScanOptionAllowDuplicatesKey : "NO"])
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        println("Found IT!")
        
        self.discoveredPeripheral = peripheral
        
        self.centralManager.connectPeripheral(peripheral, options: nil)
        
        
    }
    
//    func peripheral(peripheral: CBPeripheral!, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
//
//    }

    func centralManagerDidUpdateState(central: CBCentralManager!) {
        println("CHecking State")
        
        switch(central.state){
        case .PoweredOff:
            println("Bluetooth is off")
            
        case .PoweredOn:
            bluetoothOn = true
            println("CoreBluetooth BLE hardware is running")
            
        case .Resetting:
            println("CoreBluetooth BLE hardware is resetting")
            
        case .Unauthorized:
            println("CoreBluetooth BLE state is unauthorized")
            
        case .Unknown:
            println("CoreBluetooth BLE state is unknown");
            
        case .Unsupported:
            println("CoreBluetooth BLE hardware is unsupported on this platform");
        }
        

        
        
        
        
        
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


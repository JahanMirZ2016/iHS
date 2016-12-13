//
//  BarcodeVC.swift
//  iHS Swift
//
//  Created by arash on 11/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit
import AVFoundation

/*
 Arash : Section1 - Barcode View Controller
 */

class BarcodeVC: UIViewController , AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var viewForQRReader: UIView!
    
    var registerName = String()
    var captureSession : AVCaptureSession?
    var videoPreviewLayer : AVCaptureVideoPreviewLayer?
    var qrCodeFrameView : UIView?
    
    // Added to support different barcodes
    //    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestures()
        makeCaptureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if captureSession?.running == false {
            captureSession?.startRunning()
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession?.running == true {
            captureSession?.stopRunning()
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        captureSession?.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(readableObject.stringValue)
        }
    }
    
    
    func found (code : String ) {
        do {
            
            let jsonQRData = try JSONSerializer.toDictionary(code)
            let centerIP = jsonQRData["CenterIP"] as! String
            let centerPort = jsonQRData["CenterPort"] as! Int
            let exkey = jsonQRData["ExKey"] as! String
            
            Printer("Json Of Barcode : \(jsonQRData)")
            
            if DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CenterIP, UpdateValue: centerIP) && DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CenterPort, UpdateValue: String(centerPort)) && DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ExKey, UpdateValue: exkey) {
                let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
                appDel.socket.open(IP: centerIP, Port: centerPort)
                let serial = UIDevice.currentDevice().identifierForVendor?.UUIDString
                // Arash : Creating model for sending json.
                let verificationModel = VerificationModel()
                verificationModel.Type = "RequestRegisterMobile"
                verificationModel.MobileName = registerName
                verificationModel.ExKey = exkey
                verificationModel.Serial = serial!
                
                Printer("Json of VerificationModel \(verificationModel)")
                
                let jsonData = JSONSerializer.toJson(verificationModel).stringByAppendingString("\n")
                Printer("Json of JsonData \(jsonData)")
                
                
                if appDel.socket.send(jsonData) {
                    let vc = UIStoryboard(name: "Main" , bundle: nil).instantiateViewControllerWithIdentifier("SecondPageTBC")
                    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
                    
                    appDel.window!.rootViewController = vc
                    appDel.window!.makeKeyAndVisible()
                    dismissViewControllerAnimated(true, completion: nil)
                    
                }
                
            }
        } catch let err as NSError {
            Printer(err.debugDescription)
        }
    }
    
    /// Function for make a capture view for capture and read barcode
    func makeCaptureView() {
        captureSession = AVCaptureSession()
        
        let captureDevices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        var videoInput : AVCaptureDeviceInput?
        
        do {
            for device in captureDevices {
                if device.position == AVCaptureDevicePosition.Back {
                    videoInput = try AVCaptureDeviceInput(device: device as! AVCaptureDevice)
                }
            }
            
            if captureSession!.canAddInput(videoInput) {
                captureSession!.addInput(videoInput)
            } else {
                Printer("The captureSession can't add input")
                return
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if captureSession!.canAddOutput(metadataOutput) {
                captureSession!.addOutput(metadataOutput)
                
                metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
                metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
                
                //                viewForQRReader.layer.removeFromSuperlayer()
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer!.frame = CGRectMake(0 , 0 , WIDTHPHONE/1.5 , HEIGHTPHONE/2.4)
                videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
                viewForQRReader.layer.addSublayer(videoPreviewLayer!)
            } else {
                Printer("capture session can't add output")
                return
            }
            
        } catch let errr as NSError{
            Printer(errr.debugDescription)
            return
        }
    }
    
    
    
    
    /// Arash : Set gestures.
    func setGestures() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(goToRegisterVC))
        view.addGestureRecognizer(pan)
    }
    
    /// Arash : dismiss BarcodeVC and go to RegisterVC.
    func goToRegisterVC(sender : UIPanGestureRecognizer) {
        let transition = sender.translationInView(self.view)
        if transition.x > 0 {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    
}

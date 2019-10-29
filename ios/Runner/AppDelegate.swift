import UIKit
import Flutter

import AVFoundation



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
      ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
         let batteryChannel = FlutterMethodChannel(name: "samples.flutter.dev/player",
                                                   binaryMessenger: controller.binaryMessenger)
         batteryChannel.setMethodCallHandler({
           (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
           // Note: this method is invoked on the UI thread.
           // Handle battery messages.
            
            batteryChannel.setMethodCallHandler({
              [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
              // Note: this method is invoked on the UI thread.
              guard call.method == "playMusic" else {
                result(FlutterMethodNotImplemented)
                return
                }
                self?.playSound(result: result)
                self?.vibrate()
            })
            
         })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      }
    
    private func vibrate(){
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        } else {
            print("Vibration not Available :(")
            // Fallback on earlier versions
        }
        
    }
    //MARK: Audio Player
    var player = AVPlayer()
    let songURL = "https://firebasestorage.googleapis.com/v0/b/mixtape-test-74cfe.appspot.com/o/music%2Fawa%2FMacCunn%20-%20The%20Lay%20of%20the%20Last%20Minstrel%20(Part%202%20Final%20chorus%20O%20Caledonia).flac?alt=media"
    private func playSound(result: FlutterResult){
        
        print("Playing Music")
        let url = songURL
        let playerItem = AVPlayerItem( url:NSURL( string:url )! as URL )
        player = AVPlayer(playerItem:playerItem)
        player.rate = 1.0;
        player.play()
        
        

        
        
    }
    
    
    
}





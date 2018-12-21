////
////  AppDelegate+CarPlay.swift
////  CarPlayTest
////
////  Created by dlernatovich on 12/17/18.
////  Copyright © 2018 dlernatovich. All rights reserved.
////
//
//import UIKit
//import CarPlay
//import MediaPlayer
//
///// Instance of the {@link CarPlayComposer}
//var composer: CarPlayComposer?;
//
//// MARK: - Extension which provide the car play functionality
//extension AppDelegate: CPApplicationDelegate {
//
//    /// Method which provide the action when the application connected to CarPlay
//    ///
//    /// - Parameters:
//    ///   - application: instance of the {@link UIApplication}
//    ///   - interfaceController: instance of the {@link CPInterfaceController}
//    ///   - window: instance of the {@link CPWindow}
//    func application(_ application: UIApplication,
//                     didConnectCarInterfaceController interfaceController: CPInterfaceController,
//                     to window: CPWindow) {
//        composer = CarPlayComposer.init(withApplication: application,
//                                        withController: interfaceController,
//                                        withWindow: window);
//    }
//
//    /// Method which provide the disconnecting from CarPlay functionality
//    ///
//    /// - Parameters:
//    ///   - application: instance of the {@link UIApplication}
//    ///   - interfaceController: instance of the {@link CPInterfaceController}
//    ///   - window: instance of the {@link CPWindow}
//    func application(_ application: UIApplication,
//                     didDisconnectCarInterfaceController interfaceController: CPInterfaceController,
//                     from window: CPWindow) {
//        composer = nil;
//    }
//
//}

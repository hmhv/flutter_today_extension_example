//
//  TodayViewController.swift
//  today
//
//  Created by MYUNGHOON HONG on 2020/02/09.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import UIKit
import NotificationCenter
import Flutter

class TodayViewController: UIViewController, NCWidgetProviding {

    lazy var flutterEngine = FlutterEngine(name: "TodayViewController")

    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded

        flutterEngine.run(withEntrypoint: "mainForTodayExtension", libraryURI: nil)
        addFlutterVC()
    }

    func addFlutterVC() {
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        flutterViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(flutterViewController)
        view.addSubview(flutterViewController.view)

        flutterViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        flutterViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        flutterViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        flutterViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        flutterViewController.didMove(toParent: self)
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if (activeDisplayMode == NCWidgetDisplayMode.compact) {
            self.preferredContentSize = maxSize;
        } else {
            self.preferredContentSize = CGSize(width: 0, height: 200);
        }
    }
    
}

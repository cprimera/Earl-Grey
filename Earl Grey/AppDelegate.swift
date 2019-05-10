//
//  AppDelegate.swift
//  Earl Grey
//
//  Created by Christopher Primerano on 2019-05-09.
//  Copyright © 2019 Christopher Primerano. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
	var process: Process?
	
	var buttonEnabled: Bool = false {
		didSet {
			self.caffeinateStatusChanged(newStatus: self.buttonEnabled)
		}
	}

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		self.buttonEnabled = false
		statusItem.button?.imageScaling = .scaleProportionallyUpOrDown
		statusItem.button?.contentTintColor = NSColor.labelColor
		statusItem.button?.target = self
		statusItem.button?.action = #selector(AppDelegate.handleButton(sender:))
	}
	
	@objc
	func handleButton(sender: NSStatusBarButton) {
		self.buttonEnabled = !self.buttonEnabled
	}
	
	func caffeinateStatusChanged(newStatus: Bool) {
		let imageName: String
		if newStatus {
			imageName = "Enabled"
			self.process = Process()
			self.process!.executableURL = URL(fileURLWithPath: "/usr/bin/caffeinate")
			self.process!.arguments = ["-d", "-w", "\(ProcessInfo.processInfo.processIdentifier)"]
			try? self.process!.run()
		} else {
			imageName = "Disabled"
			self.process?.terminate()
		}
		statusItem.button?.image = NSImage(named: imageName)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}


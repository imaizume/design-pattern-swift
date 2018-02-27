//
//  chap17.swift
//  design_pattern
//
//  Created by Tomohiro Imaizumi on 2018/02/28.
//  Copyright © 2018年 imaizume. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let myObserver = Notification.Name("myObserver")
}

class RandomNumberGenerator {
    static func execute(times: Int) {
        for _ in 0..<times {
            NotificationCenter.default.post(
                name: .myObserver,
                object: nil,
                userInfo: ["number": Int(arc4random_uniform(50))]
            )
        }
    }

    public static func run() {
        let observer1 = DigitObserver()
        let observer2 = GraphObserver()
        observer1.addObserver()
        observer2.addObserver()
        RandomNumberGenerator.execute(times: 20)
        observer1.removeObserver()
        observer2.removeObserver()
    }
}

class Observer {
    public func addObserver() {
        let center = NotificationCenter.default
        center.addObserver(
            self,
            selector: #selector(type(of: self).update(notification:)),
            name: .myObserver,
            object: nil
        )
    }

    public func removeObserver() {
        let center = NotificationCenter.default
        center.removeObserver(
            self,
            name: .myObserver,
            object: nil
        )
    }

    @objc public func update(notification: Notification) {}
}

class DigitObserver: Observer {
    public override func update(notification: Notification) {
        if let number = notification.userInfo?["number"] as? Int {
            print("DigitObserver: \(number)")
            Thread.sleep(forTimeInterval: 0.1)
        }
    }
}

class GraphObserver: Observer {
    public override func update(notification: Notification) {
        if let number = notification.userInfo?["number"] as? Int {
            print("GraphObserver: ", terminator: "")
            print(String(repeating: "*", count: number))
            Thread.sleep(forTimeInterval: 0.1)
        }
    }
}


//
//  NWPathMonitorManager.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 2/1/25.
//

import UIKit

import Network

final class NWPathMonitorManager {
    
    static let shared = NWPathMonitorManager()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    var isMonitoring = false
    
    private init() {}

    func startNetworkTracking() {
        guard !isMonitoring else { return }
        isMonitoring = true
        
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    print("인터넷 연결됨")
                } else {
                    print("인터넷 연결 안 됨")
                    // 인터넷 복구 시 API 재시도 로직 짜야함
                }
            }
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
        isMonitoring = false
    }
}


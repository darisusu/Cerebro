//
//  PlacementManager.swift
//  Cerebro
//
//  Created by Darius Deng on 6/8/25.

// MARK: - PlacementManager: listens for plane and anchor updates


import Foundation
import ARKit
import RealityKit
import QuartzCore
import SwiftUI

@Observable
@MainActor
class PlacementManager {
    
    private let worldTracking = WorldTrackingProvider()
    private let planeDetection = PlaneDetectionProvider()
    
//    private var planeAnchorHandler: PlaneAnchorHandler
//    private var persistenceManager: PersistenceManager
    
    var appState: AppState? = nil {
        didSet {
            persistenceManager.placeableObjectsByFileName = appState?.placeableObjectsByFileName ?? [:]
        }
    }
    
    func startListening() async {
        // Listen to world anchor updates
        Task.detached { [weak self] in
            guard let self else { return }
            for await anchorUpdate in self.worldTracking.anchorUpdates {
                print("World anchor updated: \(anchorUpdate)")
            }
        }
        
        // Listen to plane detection updates
        Task.detached { [weak self] in
            guard let self else { return }
            for await anchorUpdate in self.planeDetection.anchorUpdates {
                print("Plane detected or updated: \(anchorUpdate)")
            }
        }
    }

}

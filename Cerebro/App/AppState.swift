//
//  AppState.swift
//  Cerebro
//
//  Created by Darius Deng on 6/8/25.
//

/*
 Abstract:
 The app’s overall state.
 Manage AR session and auth
 acts as a container to store state and logic
*/

import Foundation
import ARKit
import RealityKit

@Observable
@MainActor
class AppState {
    @Published var isTracking = false //is AR session running
    @Published var worldSensingAuthorized = false // did user grant perms
    
    var arkitSession = ARKitSession()
    @Published var providersStoppedWithError = false
    
    @Published var worldSensingAuthorizationStatus = ARKitSession.AuthorizationStatus.notDetermined
    
    var allRequiredAuthorizationsAreGranted: Bool {
        worldSensingAuthorizationStatus == .allowed
    }
    
    var allRequiredProvidersAreSupported: Bool {
        WorldTrackingProvider.isSupported && PlaneDetectionProvider.isSupported
    }
    
    var canEnterImmersiveSpace: Bool {
        allRequiredAuthorizationsAreGranted && allRequiredProvidersAreSupported
    }

    func requestWorldSensingAuthorization() async {
        let authorizationResult = await arkitSession.requestAuthorization(for: [.worldSensing])
        worldSensingAuthorizationStatus = authorizationResult[.worldSensing]!
    }
    
    func queryWorldSensingAuthorization() async {
        let authorizationResult = await arkitSession.queryAuthorization(for: [.worldSensing])
        worldSensingAuthorizationStatus = authorizationResult[.worldSensing]!
    }
    

    func monitorSessionEvents() async {
        for await event in arkitSession.events {
            switch event {
            case .dataProviderStateChanged(_, let newState, let error):
                switch newState {
                case .initialized:
                    break
                case .running:
                    break
                case .paused:
                    break
                case .stopped:
                    if let error {
                        print("An error occurred: \(error)")
                        providersStoppedWithError = true
                    }
                @unknown default:
                    break
                }
            case .authorizationChanged(let type, let status):
                print("Authorization type \(type) changed to \(status)")
                if type == .worldSensing {
                    worldSensingAuthorizationStatus = status
                }
            default:
                print("An unknown event occured \(event)")
            }
        }
    }
    
    func startSession() async {
        do {
            try await arkitSession.run([
                WorldTrackingProvider(),
                PlaneDetectionProvider()
            ])
        } catch {
            print("Failed to start ARKitSession: \(error)")
        }
    }
}



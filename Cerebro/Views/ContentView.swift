//
//  ContentView.swift
//  Cerebro
//
//  Created by Darius Deng on 6/8/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    

    let appState: AppState
    @State private var placementManager = PlacementManager()

    let immersiveSpaceIdentifier: String

    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var immersiveSpaceOpened = false
    
    var body: some View {
        VStack {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)
            
            Text("Hello, welcome!")
            
            // ToggleImmersiveSpaceButton()
            
            
            //Button to open/close immersive space
            Button("Enter Immersive Space") {
                Task {
                    switch await openImmersiveSpace(id: immersiveSpaceIdentifier) {
                        //immersivespaceidentifier represents string name chosen ltr
                    case .opened:
                        immersiveSpaceOpened = true
                    case .error:
                        print("Failed to open immersive space")
                    case .userCancelled:
                        print("User canceled immersive entry")
                    @unknown default:
                        break
                    }
                }
            }
            
            if immersiveSpaceOpened { // if true
                Button("Exit Immersive Space") {
                    Task {
                        await dismissImmersiveSpace()
                        immersiveSpaceOpened = false
                    }
                }
            }
        }
        .padding()
        .onChange(of: scenePhase, initial: true) {
        //if inactive or switch away or user minimize
            if scenePhase != .active && immersiveSpaceOpened {
                Task {
                    await dismissImmersiveSpace()
                    immersiveSpaceOpened = false
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
//    ContentView(immersiveSpaceIdentifier: "ImmersiveSpace")
        //.environment(AppModel())
    ContentView()
}
    

/*
    get authorization for detecting planes
    static var requiredAuthorizations: [ARKitSession.AuthorizationType] { get }
    
    var sphere: ModelEntity{
        let mesh = MeshResource.generateSphere(radius: 0.5)
        let material = SimpleMaterial(color: .yellow, isMetallic: true)
        let sphereEntity = ModelEntity(mesh: mesh, materials: [material])
        return sphereEntity
    }
    
    
    var planeEntity: Entity = {
        //anchors to a part of the wall
        let wallAnchor = AnchorEntity(.plane(.vertical,
                                             classification: .wall,
                                             minimumBounds: [0.01,0.01]))
        let material = SimpleMaterial(color: .green, isMetallic: false)
        let wallPlane = ModelEntity(
            mesh: .generatePlane(width: 0.1, height: 0.1),
            materials: [material]
        )
        //rotate flat plane to be vertical
        wallPlane.transform.rotation = simd_quatf(angle: -.pi / 2,
                                                  axis: [1, 0, 0])
        //attach to anchor
        wallAnchor.addChild(wallPlane)
        return wallAnchor
    }()
    
}
    var body: some View {
        
        
        RealityView { content in

            let anchorCeiling = AnchorEntity(plane: .horizontal, classification: .ceiling)
            let anchorFloor = AnchorEntity(plane: .horizontal, classification: .floor)
            let anchorWall = AnchorEntity(plane: .horizontal, classification: .wall)

            //Attach sphere
            anchorCeiling.addChild(sphere)
            anchorFloor.addChild(sphere)
            anchorWall.addChild(sphere)

            content.add(anchorCeiling)
            content.add(anchorFloor)
            content.add(anchorWall)
            //mixed immersion spaces

            // type of planes to detect
            let horizontalPlaneDet = PlaneDetectionProvider(
                alignments: [.horizontal])
            let verticalPlaneDet = PlaneDetectionProvider(
                alignments: [.vertical]


                let session = ARKitSession()
                // Start Session that requests implicit auth to use world sensing
                Task {
                    //get auth
                    let requiredAuths = PlaneDetectionProvider.requiredAuthorizations
                    let authResults = await session.requestAuthorization(for: requiredAuths)

                    do {
                        try await session.run([horizontalPlaneDet, verticalPlaneDet])
                        // Update app based on the planeData.anchorUpdates async sequence.
                    } catch {
                        print("ARKitSession error:", error)
                    }
                }

                // wait for updates
                for await update in horizontalPlaneDet.anchorUpdates {
                    let anchorEntity = AnchorEntity(anchor: update.anchor)
                    anchorEntity.addChild(sphere.clone(recursive: true))
                    content.add(anchorEntity)
                }


                for await update in verticalPlaneDet.anchorUpdates {
                    let anchorEntity = AnchorEntity(anchor: update.anchor)
                    anchorEntity.addChild(sphere.clone(recursive: true))
                    content.add(anchorEntity)
                }



        }
    }
}
*/

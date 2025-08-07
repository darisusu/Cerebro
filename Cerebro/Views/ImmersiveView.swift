//
//  ImmersiveView.swift
//  Cerebro
//
//  Created by Darius Deng on 6/8/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
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
            mesh: .generatePlane(width: 5, height: 5),
            materials: [material]
        )
        wallPlane.name = "wall"
//        let planeMesh = MeshResource.generatePlane(width:,depth:,cornerRadius:)
        //rotate flat plane to be vertical
        
//        wallPlane.transform.rotation = simd_quatf(angle: -.pi / 2,
//                                                  axis: [1, 0, 0])
//        
        
        wallAnchor.addChild(wallPlane) //attach to anchor
        return wallAnchor
    }()
    
    var body: some View {
        RealityView { content in
                content.add(planeEntity)
                content.add(sphere)

        }
    }
}
    
    
    

//    var body: some View {
//        RealityView { content in
//            // Add the initial RealityKit content
//            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
//                content.add(immersiveContentEntity)
//
//                // Put skybox here.  See example in World project available at
//                // https://developer.apple.com/
//            }
//        }
//    }
//}

#Preview(immersionStyle: .full) {
    ImmersiveView()
        .environment(AppModel())
}

//
//  CerebroApp.swift
//  Cerebro
//
//  Created by Darius Deng on 6/8/25.
//

import SwiftUI


private enum UIIdentifier {
    static let immersiveSpace = "Object Placement"
}

@main
@MainActor
struct CerebroApp: App {
    //    @State private var appState = AppState()
    //    @State private var modelLoader = ModelLoader()
    
    //functions to be used ltr
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup { //main 2D window
            //calls on the contentview viewpage
            ContentView()
        }
        //need to load models async here...
    
        
        ImmersiveSpace(id: "ImmersiveSpace"){ // shown when enter immersive space
            ImmersiveView()
        }
//        .onChange(of: scenePhase, intial: true){
//            if scenePhase != .active, immersiveSpaceOpened {
//                Task {
//                    await dismissImmersiveSpace()
//                    immersiveSpaceOpened = false
                
//                }
//            }
//        }
    }
}
    
    
    
//    @State var immersionStyle: ImmersionStyle = .mixed //mixed space
//    
//    var body: some Scene {
//        ImmersiveSpace {
//            ContentView()
//        }
//        .immersionStyle(selection: $immersionStyle,
//                        in: .mixed, .full, .progressive)
//    }
//}


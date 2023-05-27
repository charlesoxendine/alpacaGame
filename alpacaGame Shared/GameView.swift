//
//  GameView.swift
//  alpacaGame iOS
//
//  Created by Charles Oxendine on 5/26/23.
//

import SwiftUI
import SceneKit

var gameController: GameController!
let gameManager = GameManager.shared

struct GameView: View {
    var gameController: GameController! = GameController(sceneRenderer: sceneView)
    let gameManager = GameManager.shared
    
    var body: some View {
        SceneView(scene: gameController.scene)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

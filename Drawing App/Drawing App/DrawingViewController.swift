//
//  DrawingViewController.swift
//  Drawing App
//
//  Created by Samantha Webster on 12/11/20.
//  Copyright © 2020 Samantha Webster. All rights reserved.
//

import Foundation
import UIKit

class DrawingViewController: UIViewController {

    //Object Connections
    @IBOutlet var drawingMainView: UIView!
    
    @IBOutlet weak var drawingSaveButton: UIButton!
    
   
    @IBOutlet weak var buttonRed: UIButton!
    @IBOutlet weak var buttonOrange: UIButton!
    @IBOutlet weak var buttonYellow: UIButton!
    @IBOutlet weak var buttonGreen: UIButton!
    @IBOutlet weak var buttonBlue: UIButton!
    @IBOutlet weak var buttonEraser: UIButton!
    @IBOutlet weak var buttonFavorite: UIButton!
    @IBOutlet weak var buttonUndo: UIButton!
    
    
    
    @IBAction func pressButtonOrange(_ sender: Any) {
        canvas.setStrokeColor(color: .orange)
    }
    
    @IBAction func pressButtonRed(_ sender: Any) {
        canvas.setStrokeColor(color: .red)
    }
    
    @IBAction func pressButtonYellow(_ sender: Any) {
        canvas.setStrokeColor(color: .yellow)
    }
    
    @IBAction func pressButtonGreen(_ sender: Any) {
        canvas.setStrokeColor(color: .green)
    }
    
    @IBAction func pressButtonBlue(_ sender: Any) {
        canvas.setStrokeColor(color: .blue)
    }

    
    @IBAction func pressButtonFav(_ sender: Any) {
        if buttonFavorite.backgroundColor == UIColor.clear {
            self.tabBarController!.selectedIndex = 2
        } else {
            
            canvas.setStrokeColor(color: buttonFavorite.backgroundColor ?? .red)
        }
    }
    
    @IBAction func pressButtonUndo(_ sender: Any) {
        canvas.undo()
    
    }
    
    
    @IBAction func buttonColors(_ sender: Any) {
        

    }
    
    @IBAction func clickSave(_ sender: Any) {
    
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
    }
    
    let canvas = DrawingPad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvas)
        canvas.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 175)
        canvas.backgroundColor = .clear

        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }

    @objc func didTapView() {
        self.view.endEditing(true)
    }
}

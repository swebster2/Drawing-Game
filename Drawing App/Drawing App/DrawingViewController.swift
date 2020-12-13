//
//  DrawingViewController.swift
//  Drawing App
//
//  Created by Samantha Webster on 12/11/20.
//  Copyright © 2020 Samantha Webster. All rights reserved.
//

import Foundation
import UIKit

class Canvas: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.butt)

        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
    }
    
    var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}

class DrawingViewController: UIViewController {

    //Object Connections
    @IBOutlet var drawingMainView: UIView!
    
    @IBOutlet weak var drawingSaveButton: UIButton!
    
   
    @IBOutlet weak var buttonRed: UIButton!
    @IBOutlet weak var buttonOrange: UIButton!
    @IBOutlet weak var buttonYellow: UIButton!
    @IBOutlet weak var buttonGreen: UIButton!
    @IBOutlet weak var buttonBlue: UIButton!
    @IBOutlet weak var buttonPurple: UIButton!
    
    
    @IBAction func buttonColors(_ sender: Any) {
        
        
        
        }
    
    @IBAction func clickSave(_ sender: Any) {
    
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    
        
        
        
       
        
        
        
        
        
        
        
        
    }
    
    let canvas = Canvas()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvas)
        canvas.frame = view.frame
        canvas.backgroundColor = .clear

        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }

    @objc func didTapView() {
        self.view.endEditing(true)
    }
}

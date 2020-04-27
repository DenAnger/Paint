//
//  ViewController.swift
//  Paint
//
//  Created by Denis Abramov on 31.03.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var tempImageView: UIImageView!
    
    // MARK: - Properties
    var lastPoint = CGPoint.zero
    
    var color = UIColor.black
    
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
        
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let navigationController = segue.destination as? UINavigationController,
            let settingsController = navigationController.topViewController as? SettingsViewController
            else {
            return
        }
        settingsController.delegate = self
        settingsController.brush = brushWidth
        settingsController.opacity = opacity
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        settingsController.red = red
        settingsController.green = green
        settingsController.blue = blue
    }
    
    // MARK: - Actions
    @IBAction func pencilPressed(_ sender: UIButton) {
        guard let pencil = Pencil(tag: sender.tag) else {
            return
        }

        color = pencil.color
        if pencil == .eraser {
            opacity = 1.0
        }
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        mainImageView.image = nil
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        guard let image = mainImageView.image else {
            return
        }
        let activity = UIActivityViewController(activityItems: [image],
                                                applicationActivities: nil)
        present(activity, animated: true)
    }
    
    //MARK: - Methods
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        tempImageView.image?.draw(in: view.bounds)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        
        context.strokePath()
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        swiped = false
        lastPoint = touch.location(in: view)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        swiped = true
        let currentPoint = touch.location(in: view)
        drawLine(from: lastPoint, to: currentPoint)
        
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
            drawLine(from: lastPoint, to: lastPoint)
        }
        
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: view.bounds,
                                  blendMode: .normal,
                                  alpha: 1.0)
        tempImageView.image?.draw(in: view.bounds,
                                  blendMode: .normal,
                                  alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
    }
}

// MARK: - Extensions
extension ViewController: SettingsViewControllerDelegate {
    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController) {
        brushWidth = settingsViewController.brush
        opacity = settingsViewController.opacity
        
        color = UIColor(red: settingsViewController.red,
                        green: settingsViewController.green,
                        blue: settingsViewController.blue,
                        alpha: opacity)
        
        dismiss(animated: true)
    }
}

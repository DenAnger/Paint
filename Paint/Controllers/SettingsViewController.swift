//
//  SettingsViewController.swift
//  Paint
//
//  Created by Denis Abramov on 24.04.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController)
}

class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var colorView: UIImageView!
    
    @IBOutlet var brushSlider: UISlider!
    @IBOutlet var opacitySlider: UISlider!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var brushLabel: UILabel!
    @IBOutlet var opacityLabel: UILabel!
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    // MARK: - Properties
    var brush: CGFloat = 0.0
    var opacity: CGFloat = 1.0
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    weak var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        brushSlider.value = Float(brush)
        brushLabel.text = String(format: "%.1f", brush)
        opacitySlider.value = Float(opacity)
        opacityLabel.text = String(format: "%.1f", opacity)
        
        redSlider.value = Float(red * 255.0)
        redLabel.text = Int(redSlider.value).description
        greenSlider.value = Float(green * 255.0)
        greenLabel.text = Int(greenSlider.value).description
        blueSlider.value = Float(blue * 255.0)
        blueLabel.text = Int(blueSlider.value).description
        
        drawPreview()
    }
    
    // MARK: - Actions
    @IBAction func cancelPressed(_ sender: Any) {
        delegate?.settingsViewControllerFinished(self)
    }
    
    @IBAction func brushChanged(_ sender: UISlider) {
        brush = CGFloat(sender.value)
        brushLabel.text = String(format: "%.1f", brush)
        drawPreview()
    }
    
    @IBAction func opacityChanged(_ sender: UISlider) {
        opacity = CGFloat(sender.value)
        opacityLabel.text = String(format: "%.1f", opacity)
        drawPreview()
    }
    
    @IBAction func rgbChanged(_ sender: UISlider) {
        red = CGFloat(redSlider.value / 255.0)
        redLabel.text = Int(redSlider.value).description
        
        green = CGFloat(greenSlider.value / 255.0)
        greenLabel.text = Int(greenSlider.value).description
        
        blue = CGFloat(blueSlider.value / 255.0)
        blueLabel.text = Int(blueSlider.value).description
        
        drawPreview()
    }
    
    // MARK: - Methods
    func drawPreview() {
        UIGraphicsBeginImageContext(colorView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.setLineCap(.round)
        context.setLineWidth(brush)
        context.setStrokeColor(UIColor(red: red,
                                       green: green,
                                       blue: blue,
                                       alpha: opacity).cgColor)
        context.move(to: CGPoint(x: 45, y: 45))
        context.addLine(to: CGPoint(x: 45, y: 45))
        context.strokePath()
        colorView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}

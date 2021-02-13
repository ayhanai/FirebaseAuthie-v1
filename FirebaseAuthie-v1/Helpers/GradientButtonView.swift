//
//  GradientView.swift
//  FirebaseAuth
//
//  Created by Sayajin Papuru on 2/12/21.
//

import Foundation
import UIKit

@IBDesignable
class GradientButtonView: UIButton {

        @IBInspectable var firstColor: UIColor = UIColor.clear {
            didSet {
                updateView()
            }
        }
        @IBInspectable var secondColor: UIColor = UIColor.clear {
            didSet {
                updateView()
            }
        }
        
        override open class var layerClass: AnyClass {
            get {
                return CAGradientLayer.self
            }
        }
        
        func updateView() {
            let layer = self.layer as! CAGradientLayer
            layer.colors = [firstColor.cgColor, secondColor.cgColor]
        }
}

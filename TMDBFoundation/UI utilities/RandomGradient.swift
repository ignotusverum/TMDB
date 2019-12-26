//
//  RandomGradient.swift
//  moVimento
//
//  Created by Giuseppe Lanza on 07/09/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import UIKit

public class RandomGradient: CALayer {
    public override var frame: CGRect {
        didSet {
            sublayers?.forEach { $0.frame = CGRect(origin: .zero, size: frame.size) }
        }
    }
    
    public override init() {
        super.init()
        
        zip((0..<4).map { UIColor.random().withAlphaComponent(1/CGFloat($0 + 1)) }, [
            (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1)),
            (CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1)),
            (CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 0)),
            (CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0))
        ]).map { (arg) -> CAGradientLayer in
            let (color, points) = arg
            let gradient = CAGradientLayer()
            gradient.colors = [color.cgColor, UIColor.clear.cgColor]
            gradient.locations = [0.0, 1.0]
            gradient.startPoint = points.0
            gradient.endPoint = points.1
            
            return gradient
        }.forEach { addSublayer($0) }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func image(withSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        
        let layer = RandomGradient()
        layer.frame = CGRect(origin: .zero, size: size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}

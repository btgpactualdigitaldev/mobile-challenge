//
//  Btg+UIImage.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 19/11/20.
//


import UIKit

@IBDesignable
extension UIImage {
    open var width: CGFloat {
        return size.width
    }
    
    open var height: CGFloat {
        return size.height
    }
    
    open func resize(toWidth w: CGFloat) -> UIImage? {
        return internalResize(toWidth: w)
    }
    
    open func resize(toHeight h: CGFloat) -> UIImage? {
        return internalResize(toHeight: h)
    }

    private func internalResize(toWidth tw: CGFloat = 0, toHeight th: CGFloat = 0) -> UIImage? {
        var w: CGFloat?
        var h: CGFloat?
        if 0 < tw {
            h = height * tw / width
        }
        else if 0 < th {
            w = width * th / height
        }
        
        let g: UIImage?
        let t: CGRect = CGRect(x: 0, y: 0, width: w ?? tw, height: h ?? th)
        UIGraphicsBeginImageContextWithOptions(t.size, false, UIScreen.main.scale)
        draw(in: t, blendMode: .normal, alpha: 1)
        g = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return g
    }
}

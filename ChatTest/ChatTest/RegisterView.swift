//
//  RegisterView.swift
//  ChatTest
//
//  Created by MC-MG57035 on 5/2/2560 BE.
//  Copyright © 2560 Dol2oMo. All rights reserved.
//

import UIKit
import QuartzCore

class RegisterView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
 
    
    public func ViewRegister(regisview:UIView) -> Any{
        
        let registerview = RegisterView.init(frame: regisview.bounds)
        
        registerview.isOpaque = false
        registerview.autoresizingMask = [.flexibleHeight , .flexibleWidth]
        
        regisview .addSubview(registerview)
        
        let animation = CATransition()
        animation .type = kCATransitionFade
        regisview.layer .add(animation, forKey: "layerAnimation")
        
        
        
        
        return regisview
    }
    
    
    func removeview() {
        
        let Mysuperview:UIView? = self.superview

        
        print("ggggghfghfghfh")
        
        super.removeFromSuperview()

        
        
        let animation = CATransition()
        animation .type = kCATransitionFade
        Mysuperview?.layer .add(animation, forKey: "layerAnimation")
        
    }
    
    
    
    override func draw(_ rect: CGRect) {
//        let rects = CGRect(x:5 , y:5, width: rect.size.width - 10 , height: rect.size.height - 10)
        let rects = CGRect(x:rect.midX - 60 , y:rect.midY - 45 , width: 120 , height: 70)
        
        let ROUND_RECT_CORNER_RADIUS:CGFloat = 5.0
        
        let roundRectPath: CGPath = self.PathWithRoundRect(rect: rects, cornerRadius: ROUND_RECT_CORNER_RADIUS)
        
        let context :CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        context.addPath(roundRectPath)
        context.fillPath()
        
        
        context.setStrokeColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        context.addPath(roundRectPath)
        context.strokePath()
  
    }

    private func PathWithRoundRect(rect :CGRect ,cornerRadius:CGFloat) -> CGPath
    {
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height - cornerRadius))
        
        // Top left corner
        path.addArc(tangent1End: CGPoint(x: rect.origin.x, y: rect.origin.y), tangent2End: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y), radius: cornerRadius)
        // Top right corner
        
        path.addArc(tangent1End: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y), tangent2End: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height), radius: cornerRadius)
        
        // Bottom right corner
        
        path.addArc(tangent1End: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y  + rect.size.height), tangent2End: CGPoint(x: rect.origin.x , y: rect.origin.y  + rect.size.height), radius: cornerRadius)
        
        // Bottom left corner
        
        path.addArc(tangent1End: CGPoint(x: rect.origin.x, y: rect.origin.y  + rect.size.height), tangent2End: CGPoint(x: rect.origin.x , y: rect.origin.y ), radius: cornerRadius)
        
        
        return path
        
    }

    
    

}



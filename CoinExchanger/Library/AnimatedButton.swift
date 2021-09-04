//
//  AnimatedButton.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 28/06/21.
//

import UIKit

enum AnimatedOption: Int {
    case border
    case fill
    case fade
    case replace
}

class AnimatedButton: UIButton {
    var blurEffect: UIBlurEffect.Style? { didSet { makeBlur() } }
    var blurView: UIVisualEffectView?
    var fadeOpacity: CGFloat = 0.4
    var lenght: TimeInterval = 0.3
    var option: AnimatedOption = .fade
    
    var fillRadius: CGFloat = 0 { didSet { actionView.layer.cornerRadius = fillRadius } }
    
    var animatedFillColor: UIColor = UIColor.lightGray {
        didSet { actionView.backgroundColor = animatedFillColor }
    }
    
    var animatedBackgroundColor: UIColor? //= .clear
    var animatedBorderColor: CGColor? //= UIColor.clear.cgColor
    var animatedTextColor: UIColor? //= .clear
    
    var tempBackgroundColor: UIColor? //= .clear
    var tempBorderColor: CGColor? //= UIColor.clear.cgColor
    var tempTextColor: UIColor? //= .clear
    
    private var actionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.isUserInteractionEnabled = false
        return view
    }()
    
    convenience init(_ option: AnimatedOption) {
        self.init()
        self.option = option
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override var isEnabled: Bool {
        willSet {
            if isEnabled {
                //self.tempBackgroundColor = self.backgroundColor
                self.tempBorderColor = self.layer.borderColor
                //self.tempTextColor = self.titleColor(for: .normal)
            }
        }
        
        didSet {
            if isEnabled {
                UIView.animate(withDuration: lenght, animations: {
                    self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
                    self.layer.borderColor = self.tempBorderColor
                })
            } else {
                UIView.animate(withDuration: lenght, animations: {
                    self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5)
                    self.layer.borderColor = UIColor.clear.cgColor
                })
            }
        }
    }
    
    @objc
    func animateStart() {
        switch option {
        case .border:
            borderStart()
        case .fade:
            fadeStart()
        case .fill:
            fillStart()
        case .replace:
            replaceStart()
        }
    }
    
    @objc
    func animateEnd() {
        switch option {
        case .border:
            borderEnd()
        case .fade:
            fadeEnd()
        case .fill:
            fillEnd()
        case .replace:
            replaceEnd()
        }
    }
    
    private func setup() {
        self.clipsToBounds = true
        self.addTarget(self, action: #selector(animateStart), for: .touchDown)
        self.addTarget(self, action: #selector(animateEnd), for: [.touchCancel, .touchUpOutside, .touchUpInside])
        
        //self.setTitleColor(.white, for: .disabled)
    }
    
    func makeBlur() {
        blurView?.removeFromSuperview()
        
        guard let blur = blurEffect else { return }
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: blur))
        self.insertSubview(blurView, at: 0)
        blurView.fill(to: self)
        blurView.alpha = 0.8
    }
}

extension AnimatedButton {
    func borderStart() {
        UIView.animate(withDuration: lenght, animations: {
            //self.tempBackgroundColor = self.backgroundColor
            //self.backgroundColor = self.animatedBackgroundColor
            
            self.tempBorderColor = self.layer.borderColor
            self.layer.borderColor = self.animatedBorderColor
            
            self.tempTextColor = self.titleColor(for: .normal)
            self.setTitleColor(self.animatedTextColor, for: .normal)
        })
    }
    
    func borderEnd() {
        UIView.animate(withDuration: lenght, animations: {
            //self.backgroundColor = self.tempBackgroundColor
            self.layer.borderColor = self.tempBorderColor
            self.setTitleColor(self.tempTextColor, for: .normal)
        })
    }
    
    func fadeStart() {
        UIView.animate(withDuration: lenght, animations: {
            self.alpha = self.fadeOpacity
        })
    }
    
    func fadeEnd() {
        UIView.animate(withDuration: lenght, animations: {
            self.alpha = 1
        })
    }
    
    func fillStart() {
        self.addSubview(actionView)
        self.sendSubviewToBack(actionView)
        actionView.fill(to: self)
        
        actionView.center = self.center
        actionView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: lenght, animations: {
            self.actionView.transform = .identity
        })
    }
    
    func fillEnd() {
        UIView.animate(withDuration: lenght, animations: {
            self.actionView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
         }) { (success) in
            self.actionView.removeFromSuperview()
         }
    }
    
    func replaceStart() {
        UIView.animate(withDuration: lenght, animations: {
            self.tempBackgroundColor = self.backgroundColor
            self.backgroundColor = self.animatedBackgroundColor
            
            self.tempBorderColor = self.layer.borderColor
            self.layer.borderColor = self.animatedBorderColor
            
            self.tempTextColor = self.titleColor(for: .normal)
            self.setTitleColor(self.animatedTextColor, for: .normal)
        })
    }
    
    func replaceEnd() {
        UIView.animate(withDuration: lenght, animations: {
            self.backgroundColor = self.tempBackgroundColor
            self.layer.borderColor = self.tempBorderColor
            self.setTitleColor(self.tempTextColor, for: .normal)
        })
    }
}

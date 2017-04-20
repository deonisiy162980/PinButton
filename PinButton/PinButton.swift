//
//  PinButton.swift
//  DLS
//
//  Created by Denis on 08.02.17.
//  Copyright © 2017 Denis Petrov. All rights reserved.
//

import UIKit


@IBDesignable public class PinButton: UIButton
{
    public var gradient = CAGradientLayer()
    public var colorsForGradient = [UIColor.yellow, UIColor.blue]
    public var subText : UILabel!
    
    
    
    @IBInspectable
    public var subTextOffset : CGFloat = 5
        {
        didSet {
            subText.frame = CGRect(x: self.bounds.width / 2 - subText.bounds.width / 2,
                                   y: self.bounds.height / 2 + subText.bounds.height / 2 + subTextOffset,
                                   width: subText.bounds.width,
                                   height: subText.bounds.height)
        }
    }
    @IBInspectable
    public var numberOffset : CGFloat = 10 {
        didSet {
            self.titleEdgeInsets = UIEdgeInsetsMake(-numberOffset, 0.0, 0.0, 0.0)
        }
    }
    @IBInspectable
    public var subTextColor : UIColor = UIColor.white
        {
        didSet {
            subText.textColor = subTextColor
        }
    }
    @IBInspectable
    public var borderColor : UIColor = UIColor.white
        {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable
    public var subTextSize : CGFloat = 10
        {
        didSet {
            subText.font = UIFont.systemFont(ofSize: subTextSize, weight: UIFontWeightThin)
        }
    }
    @IBInspectable
    public var borderWidth : CGFloat = 1
        {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable
    public var needSubText : Bool = true
        {
        didSet {
            addOrUpdateSubText()
        }
    }
    @IBInspectable
    public var beginColor : UIColor = .clear
        {
        didSet {
            let newGradient : [UIColor] = [beginColor, colorsForGradient.last!]
            colorsForGradient = newGradient
            configure()
        }
    }
    @IBInspectable
    public var endColor : UIColor = .clear
        {
        didSet {
            let newGradient : [UIColor] = [colorsForGradient.first!, endColor]
            colorsForGradient = newGradient
            configure()
        }
    }
    @IBInspectable
    public var gradientAlpha : CGFloat = 0.7
        {
        didSet {
            configure()
        }
    }
    @IBInspectable
    public var showGradient : Bool = false
        {
        didSet {
            configure()
        }
    }
    
    
    //MARK: Initializers
    override public init(frame : CGRect)
    {
        super.init(frame : frame)
        setup()
        configure()
    }
    
    convenience public init()
    {
        self.init(frame:CGRect.zero)
        setup()
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
        configure()
    }
    
    
    override public func awakeFromNib()
    {
        super.awakeFromNib()
        setup()
        configure()
    }
    
    override public func prepareForInterfaceBuilder()
    {
        super.prepareForInterfaceBuilder()
        setup()
        configure()
    }
    
    
    override public func layoutSublayers(of layer: CALayer)
    {
        super.layoutSublayers(of: layer)
        
        configure()
    }
}


//MARK: - EVENTS
public extension PinButton
{
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0.15) { 
            self.gradient.colors = self.colorsForGradient.map { $0.withAlphaComponent(self.gradientAlpha).cgColor }
        }
        
    }
    
    
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(withDuration: 0.15) {
            self.gradient.colors = self.colorsForGradient.map { $0.withAlphaComponent(0.0).cgColor }
        }
    }
}


//MARK: - ADD SUB TEXT
public extension PinButton
{
    fileprivate func addOrUpdateSubText()
    {
        if needSubText
        {
            if subText == nil
            {
                subText = UILabel()
                subText.font = UIFont.systemFont(ofSize: subTextSize, weight: UIFontWeightThin)
                subText.textColor = subTextColor
                
                #if TARGET_INTERFACE_BUILDER
                    subText.text = "ABC"
                #else
                    subText.text = getSubTextForButton()
                #endif
                
                subText.sizeToFit()
                
                subText.frame = CGRect(x: self.bounds.width / 2 - subText.bounds.width / 2,
                                       y: self.bounds.height / 2 + subText.bounds.height / 2 + subTextOffset,
                                       width: subText.bounds.width,
                                       height: subText.bounds.height)
                
                self.insertSubview(subText, aboveSubview: self)
            }
            else
            {
                subText.frame = CGRect(x: self.bounds.width / 2 - subText.bounds.width / 2,
                                       y: self.bounds.height / 2 + subText.bounds.height / 2 + subTextOffset,
                                       width: subText.bounds.width,
                                       height: subText.bounds.height)
            }
        }
        else
        {
            if subText != nil
            {
                subText.removeFromSuperview()
                subText = nil
            }
        }
    }
    
    
    fileprivate func getSubTextForButton() -> String
    {
        switch self.tag
        {
        case 2:
            return "ABC"
        case 3:
            return "DEF"
        case 4:
            return "GHI"
        case 5:
            return "JKL"
        case 6:
            return "MNO"
        case 7:
            return "PQRS"
        case 8:
            return "TUV"
        case 9:
            return "WXYZ"
        default:
            return ""
        }
    }
}


//MARK: - SETUP AND CONFIGURE
public extension PinButton
{
    fileprivate func setup()
    {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = self.bounds.width / 2
        
        
        self.titleEdgeInsets = UIEdgeInsetsMake(-numberOffset, 0.0, 0.0, 0.0)
        
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width - borderWidth, height: self.bounds.height - borderWidth)
        gradient.cornerRadius = gradient.bounds.width / 2
        if showGradient { gradient.colors = colorsForGradient.map { $0.withAlphaComponent(gradientAlpha).cgColor } } else { gradient.colors = colorsForGradient.map { $0.withAlphaComponent(0.0).cgColor } }
        self.layer.insertSublayer(gradient, at: 0)
        
        
        self.setTitle("\(self.tag)", for: .normal)
    }
    
    
    fileprivate func configure()
    {
        self.layer.cornerRadius = self.bounds.width / 2
        gradient.cornerRadius = gradient.bounds.width / 2
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width - borderWidth, height: self.bounds.height - borderWidth)
        
        addOrUpdateSubText()
    }
}

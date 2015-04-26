//
//  Pulse.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 15/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import QuartzCore

struct PulsarConstants {
	private static let keyPrefix: String = "Pulsar."
	static let layersKey: String = keyPrefix + "layers"
}

public typealias PulsarStartClosure = (NSTimeInterval) -> ()
public typealias PulsarStopClosure = (Bool) -> ()

public class Builder {
	public var layer: CALayer
	public var borderColors: [CGColor]
	public var backgroundColors: [CGColor]
	public var path: CGPathRef
	public var duration: NSTimeInterval = 1.0
	public var repeatCount: Int = 0
	public var lineWidth: CGFloat = 3.0
	public var startBlock: PulsarStartClosure? = nil
	public var stopBlock: PulsarStopClosure? = nil
	
	init(_ layer: CALayer) {
		self.layer = layer
		self.borderColors = Builder.defaultBorderColorsForLayer(layer)
		self.backgroundColors = Builder.defaultBackgroundColorsForLayer(layer)
		self.path = Builder.defaultPathForLayer(layer)
	}

	class func defaultBackgroundColorsForLayer(layer: CALayer) -> [CGColor] {
		switch layer {
		case let shapeLayer as CAShapeLayer:
			if let fillColor = shapeLayer.fillColor {
				let halfAlpha = CGColorGetAlpha(fillColor) * 0.5
				return [CGColorCreateCopyWithAlpha(fillColor, halfAlpha)]
			}
		default:
			if let backgroundColor = layer.backgroundColor {
				let halfAlpha = CGColorGetAlpha(backgroundColor) * 0.5
				return [CGColorCreateCopyWithAlpha(backgroundColor, halfAlpha)]
			}
		}
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let components: [CGFloat] = [1.0, 0.0, 0.0, 0.0]
		return [CGColorCreate(colorSpace, components)]
	}
	
	class func defaultBorderColorsForLayer(layer: CALayer) -> [CGColor] {
		switch layer {
		case let shapeLayer as CAShapeLayer:
			if shapeLayer.lineWidth > 0.0 {
				if let strokeColor = shapeLayer.strokeColor {
					return [strokeColor]
				}
			} else {
				if let fillColor = shapeLayer.fillColor {
					return [fillColor]
				}
			}
		default:
			if layer.borderWidth > 0.0 {
				if let borderColor = layer.borderColor {
					return [borderColor]
				}
			} else {
				if let backgroundColor = layer.backgroundColor {
					return [backgroundColor]
				}
			}
		}
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let components: [CGFloat] = [1.0, 0.0, 0.0, 0.0]
		return [CGColorCreate(colorSpace, components)]
	}
	
	class func defaultPathForLayer(layer: CALayer) -> CGPathRef {
		switch layer {
		case let shapeLayer as CAShapeLayer:
			return shapeLayer.path
		default:
			let rect = layer.bounds
			let minSize = min(CGRectGetWidth(rect), CGRectGetHeight(rect))
			let cornerRadius = min(max(0.0, layer.cornerRadius), minSize / 2.0)
			if cornerRadius > 0.0 {
				return CGPathCreateWithRoundedRect(rect, cornerRadius, cornerRadius, nil)
			} else {
				return CGPathCreateWithRect(rect, nil)
			}
		}
	}
}

class Delegate {
	
	let pulseLayer: CAShapeLayer
	let startBlock: PulsarStartClosure? = nil
	let stopBlock: PulsarStopClosure? = nil
	
	init(pulseLayer: CAShapeLayer) {
		self.pulseLayer = pulseLayer
	}
	
	func animationDidStart(animation: CAAnimation) {
		if let startBlock = self.startBlock {
			startBlock(animation.duration)
		}
	}
	
	func animationDidStop(animation: CAAnimation, finished: Bool) {
		if var pulseLayers = self.pulseLayer.superlayer?.pulsarLayers as? [CAShapeLayer] {
			if let index = find(pulseLayers, self.pulseLayer) {
				pulseLayers.removeAtIndex(index)
				self.pulseLayer.removeFromSuperlayer()
				if let stopBlock = self.stopBlock {
					stopBlock(finished)
				}
			}
		}
	}
}
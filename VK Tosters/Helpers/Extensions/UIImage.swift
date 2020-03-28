//
//  UIImage.swift
//  VK Tosters
//
//  Created by programmist_np on 25/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import ImageIO

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

extension UIImage {
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL:URL = URL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.025
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.025 {
            delay = 0.025
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a < b {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 500.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 500.0)
        
        return animation
    }
}
extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
public extension UIImage {
    static func imageWithColor(_ color: UIColor, imageSize: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContext(imageSize)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
        currentContext.setFillColor(color.cgColor)
        currentContext.fill(CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return result
    }
    
    func imageByScalingAndCropping(_ targetSize: CGSize) -> UIImage? {
        let sourceImage = self
        let newImage: UIImage?
        let imageSize = sourceImage.size
        let width = imageSize.width
        let height = imageSize.height
        let targetWidth = targetSize.width
        let targetHeight = targetSize.height
        var scaleFactor: CGFloat = 0.0
        var scaledWidth = targetWidth
        var scaledHeight = targetHeight
        var thumbnailPoint = CGPoint(x: 0.0, y: 0.0)
        
        if imageSize != targetSize {
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            
            if widthFactor > heightFactor {
                scaleFactor = widthFactor
            } else {
                scaleFactor = heightFactor
            }
            
            scaledWidth = width * scaleFactor
            scaledHeight = height * scaleFactor
            
            //center the image
            if widthFactor > heightFactor {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            } else {
                if (widthFactor < heightFactor) {
                    thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
                }
            }
        }
        
        UIGraphicsBeginImageContext(targetSize)
        
        var thumbnailRect = CGRect()
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        sourceImage.draw(in: thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        if newImage == nil {
            debugPrint("Could not scale image")
        }
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    static func roundedImage(_ image: UIImage, cornerRadius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: CGPoint.zero, size: image.size)
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, 1)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        image.draw(in: rect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
    
    func opaqueImage() -> UIImage? {
        let imageSize = size
        UIGraphicsBeginImageContextWithOptions(imageSize, true, UIScreen.main.scale)
        draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let optimizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return optimizedImage
    }
    
    func byApplyingAlpha(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
extension CGPoint {
    func rotated(around origin: CGPoint, byDegrees: CGFloat) -> CGPoint {
        let dx = self.x - origin.x
        let dy = self.y - origin.y
        let radius = sqrt(dx * dx + dy * dy)
        let azimuth = atan2(dy, dx) // in radians
        let newAzimuth = azimuth + (byDegrees * CGFloat.pi / 180.0) // convert it to radians
        let x = origin.x + radius * cos(newAzimuth)
        let y = origin.y + radius * sin(newAzimuth)
        return CGPoint(x: x, y: y)
    }
}
class ColorFilter: CIFilter {
    var inputImage: CIImage?
    var inputColor: CIColor?
    private let kernel: CIColorKernel = {
        let kernelString =
        """
        kernel vec4 colorize(__sample pixel, vec4 color) {
            pixel.rgb = pixel.a * color.rgb;
            pixel.a *= color.a;
            return pixel;
        }
        """
        return CIColorKernel(source: kernelString)!
    }()

    override var outputImage: CIImage? {
        guard let inputImage = inputImage, let inputColor = inputColor else { return nil }
        let inputs = [inputImage, inputColor] as [Any]
        return kernel.apply(extent: inputImage.extent, arguments: inputs)
    }
}
extension UIImage {
    func colorized(with color: UIColor) -> UIImage {
        guard let cgInput = self.cgImage else {
            return self
        }
        let colorFilter = ColorFilter()
        colorFilter.inputImage = CIImage(cgImage: cgInput)
        colorFilter.inputColor = CIColor(color: color)

        if let ciOutputImage = colorFilter.outputImage {
            let context = CIContext(options: nil)
            let cgImg = context.createCGImage(ciOutputImage, from: ciOutputImage.extent)
            return (UIImage(cgImage: cgImg!, scale: self.scale, orientation: self.imageOrientation) as AnyObject).withRenderingMode(self.renderingMode)
        } else {
            return self
        }
    }
}
extension UIImage {
    // Нарисовать обводку по контуру картинки (PNG прозрачный)
    func stroked(with color: UIColor, size: CGFloat) -> UIImage {
        let strokeImage = self.colorized(with: color)
        let oldRect = CGRect(x: size, y: size, width: self.size.width, height: self.size.height).integral
        let newSize = CGSize(width: self.size.width + (2 * size), height: self.size.height + (2 * size))
        let translationVector = CGPoint(x: size, y: 0)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        if let context = UIGraphicsGetCurrentContext() {
            context.interpolationQuality = .high

            let step = 10
            for angle in stride(from: 0, to: 360, by: step) {
                let vector = translationVector.rotated(around: .zero, byDegrees: CGFloat(angle))
                let transform = CGAffineTransform(translationX: vector.x, y: vector.y)
                context.concatenate(transform)
                context.draw(strokeImage.cgImage!, in: oldRect)
                let resetTransform = CGAffineTransform(translationX: -vector.x, y: -vector.y)
                context.concatenate(resetTransform)
            }
            context.draw(self.cgImage!, in: oldRect)

            let newImage = UIImage(cgImage: context.makeImage()!, scale: self.scale, orientation: self.imageOrientation)
            UIGraphicsEndImageContext()

            return newImage.withRenderingMode(self.renderingMode)
        }
        UIGraphicsEndImageContext()
        return self
    }
}

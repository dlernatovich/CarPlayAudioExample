//
//  UIImage.swift
//  MoDo
//
//  Created by Dmitry Lernatovich on 8/29/17.
//  Copyright © 2017 Magnet. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// Method which provide the convert image to the grayscale
    ///
    /// - Returns: instance of the gray scaled {@link UIImage}
    func getGrayScaleImage() -> UIImage {
        let originalScale = self.scale;
        let originalOrientation = self.imageOrientation;
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        // convert UIImage to CIImage and set as input
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")
        // get output CIImage, render as CGImage first to retain proper UIImage scale
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        let grayImage = UIImage(cgImage: cgImage!);
        return UIImage(cgImage: grayImage.cgImage!, scale: originalScale, orientation: originalOrientation);
    }
    
    /// Method which provide the image resizing
    ///
    /// - Parameter size: instance of the {@link CGSize}
    /// - Returns: instance of the {@link UIImage}
    func resize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        self.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: size.width, height: size.height)));
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    /// Method which provide the image resizing
    ///
    /// - Parameter size: instance of the {@link CGSize}
    /// - Returns: instance of the {@link UIImage}
    func resize(withProportionalSize rectSize: CGSize) -> UIImage {
        let widthFactor = self.size.width / rectSize.width;
        let heightFactor = self.size.height / rectSize.height;
        var resizeFactor = widthFactor;
        if size.height > size.width {
            resizeFactor = heightFactor;
        }
        let newSize = CGSize.init(width: size.width/resizeFactor, height: size.height/resizeFactor);
        return self.resize(size:newSize);
    }
    
    
    /// Method which provide the return of the rounded {@link UIImage}
    ///
    /// - Returns: instance of the {@link UIImage}
    func roundImage() -> UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: self.size.height
            ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    
    /// Method which provide the tint image with color
    ///
    /// - Parameter color: instance of the {@link UIColor}
    /// - Returns: instance of the {@link UIImage}
    func tintImage(withColor color: UIColor) -> UIImage {
        if let maskImage = self.cgImage {
            let width = self.size.width;
            let height = self.size.height;
            let bounds = CGRect(x: 0, y: 0, width: width, height: height);
            let colorSpace = CGColorSpaceCreateDeviceRGB();
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue);
            if let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) {
                context.clip(to: bounds, mask: maskImage);
                context.setFillColor(color.cgColor);
                context.fill(bounds);
                if let cgImage = context.makeImage() {
                    let coloredImage = UIImage(cgImage: cgImage);
                    return coloredImage;
                } else {
                    return self;
                }
            }
        }
        return self;
    }
    
    // crop image the max square region at top of image
    func cropTopSquare(targetSize:CGFloat) -> UIImage? {
        let contextSize: CGSize = self.size
        
        let portion: CGFloat = 0.7
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cropWidth: CGFloat = 0.0 //CGFloat(contextSize.width)
        var cropHeight: CGFloat = 0.0 //CGFloat(contextSize.height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height * portion) / 2)
            posY = 0
            cropWidth = contextSize.height * portion
            cropHeight = cropWidth
        } else {
            posX = ((contextSize.width - contextSize.width * portion) / 2)  //0
            posY = 0 // top rect region //((contextSize.height - contextSize.width) / 2)
            cropWidth = contextSize.width * portion
            cropHeight = cropWidth
        }

        var cropped: UIImage? = nil

        if let cgImage = self.cgImage, cropWidth > 0, cropHeight > 0 {
            let rect: CGRect = CGRect(x : posX, y : posY, width : cropWidth, height : cropHeight)
            
            if let imageRef = cgImage.cropping(to: rect) {
                cropped = UIImage(cgImage: imageRef, scale: targetSize/cropWidth, orientation: self.imageOrientation)
            }
        }
        return cropped
    }

}

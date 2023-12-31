import UIKit

/**
 A set of extensions to UIImage that provides methods for trimming and cropping images.
 
 The `trim()` method trims the transparent or white borders around an image and returns a new UIImage instance with the trimmed content.
 
 The `cropRect` computed property calculates the rectangle that bounds the non-transparent or non-white pixels in the image.
 
 Usage:
 ```
 let originalImage = UIImage(named: "original_image")
 
 // Trim the image and get the trimmed version
 let trimmedImage = originalImage.trim()
 
 // Get the crop rectangle of the image
 let cropRect = originalImage.cropRect
 
 // Perform further operations with the trimmed image or crop rectangle
 ```
 
 - Note: The `trim()` method uses the `cropRect` property to determine the region to be cropped. The `cropRect` property performs the actual calculation of the crop rectangle.
 
 - Important: The provided extension assumes that the input image has an alpha channel. If the image doesn't have an alpha channel, the trimming behavior may not be as expected.
  */
extension UIImage {
    func trim() -> UIImage {
        let newRect = self.cropRect
        if let imageRef = self.cgImage!.cropping(to: newRect) {
            return UIImage(cgImage: imageRef)
        }
        return self
    }
    
    var cropRect: CGRect {
        guard let cgImage = self.cgImage,
              let context = createARGBBitmapContextFromImage(inImage: cgImage) else {
            return CGRect.zero
        }
        
        let height = CGFloat(cgImage.height)
        let width = CGFloat(cgImage.width)
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context.draw(cgImage, in: rect)
        
        guard let data = context.data?.assumingMemoryBound(to: UInt8.self) else {
            return CGRect.zero
        }
        
        var lowX = width
        var lowY = height
        var highX: CGFloat = 0
        var highY: CGFloat = 0
        let heightInt = Int(height)
        let widthInt = Int(width)
        
        for y in 0 ..< heightInt {
            let y = CGFloat(y)
            
            for x in 0 ..< widthInt {
                let x = CGFloat(x)
                let pixelIndex = (width * y + x) * 4
                
                if data[Int(pixelIndex)] == 0 { continue }
                
                if data[Int(pixelIndex+1)] > 0xE0 && data[Int(pixelIndex+2)] > 0xE0 && data[Int(pixelIndex+3)] > 0xE0 { continue }
                
                lowX = min(x, lowX)
                highX = max(x, highX)
                
                lowY = min(y, lowY)
                highY = max(y, highY)
            }
        }
        
        return CGRect(x: lowX, y: lowY, width: highX - lowX, height: highY - lowY)
    }
    
    func createARGBBitmapContextFromImage(inImage: CGImage) -> CGContext? {
        
        let width = inImage.width
        let height = inImage.height
        
        let bitmapBytesPerRow = width * 4
        let bitmapByteCount = bitmapBytesPerRow * height
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let bitmapData = malloc(bitmapByteCount)
        if bitmapData == nil {
            return nil
        }
        
        let context = CGContext (data: bitmapData,
                                 width: width,
                                 height: height,
                                 bitsPerComponent: 8,
                                 bytesPerRow: bitmapBytesPerRow,
                                 space: colorSpace,
                                 bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        return context
    }
}

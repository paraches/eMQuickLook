//
//  PreviewViewController.swift
//  enchantMOON
//
//  Created by paraches on 2020/10/08.
//

import Cocoa
import Quartz

class PreviewViewController: NSViewController, QLPreviewingController {
    @IBOutlet weak var imageView: NSImageView!
    
    override var nibName: NSNib.Name? {
        return NSNib.Name("PreviewViewController")
    }

    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view.
    }

    /*
     * Implement this method and set QLSupportsSearchableItems to YES in the Info.plist of the extension if you support CoreSpotlight.
     *
    func preparePreviewOfSearchableItem(identifier: String, queryString: String?, completionHandler handler: @escaping (Error?) -> Void) {
        // Perform any setup necessary in order to prepare the view.
        
        // Call the completion handler so Quick Look knows that the preview is fully loaded.
        // Quick Look will display a loading spinner while the completion handler is not called.
        handler(nil)
    }
     */
    
    func preparePreviewOfFile(at url: URL, completionHandler handler: @escaping (Error?) -> Void) {
        
        // Add the supported content types to the QLSupportedContentTypes array in the Info.plist of the extension.
        
        // Perform any setup necessary in order to prepare the view.
        
        // Call the completion handler so Quick Look knows that the preview is fully loaded.
        // Quick Look will display a loading spinner while the completion handler is not called.
        
        if let moonObject = try? JSONDecoder().decode(MoonObject.self, from: Data(contentsOf: url)) {
            if let imageView = imageView, let image = createImage(moonObject) {
                imageView.image = image
            }
        }
        handler(nil)
    }
    
    private func createImage(_ moonObject: MoonObject) -> NSImage? {
        let previewRect = self.view.bounds.insetBy(dx: 2, dy: 2)
        let image = NSImage(size: previewRect.size)
        
        image.lockFocusFlipped(true)
        
        for stroke in moonObject.strokes {
            stroke.color.set()
            let s = NSBezierPath()
            let strokeLineWidth = CGFloat(stroke.width)
            s.lineWidth = strokeLineWidth

            if stroke.points.count > 1 {
                s.move(to: stroke.points[0].point)
                
                for i in 1..<stroke.points.count {
                    let moonPoint = stroke.points[i]
                    s.lineWidth = strokeLineWidth * moonPoint.width
                    s.line(to: moonPoint.point)
                }
            }

            s.close()
            s.stroke()
        }
        
        image.unlockFocus()
        
        return image
    }

}

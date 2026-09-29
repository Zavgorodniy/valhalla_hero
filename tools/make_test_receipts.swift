// Generates demo receipt QR codes for the local stack.
// Usage: swift tools/make_test_receipts.swift docs/test-receipts
// The TSE payloads use the demo register "VH-BERLIN-KASSE-1" from supabase/seeds/content.sql;
// the seed disables the receipt age check, so these stay valid until redeemed once.
import AppKit
import CoreImage
import CoreImage.CIFilterBuiltins

let outDir = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "."
let receipts: [(String, String)] = [
    ("tse-38-50", "V0;VH-BERLIN-KASSE-1;Kassenbeleg-V1;Beleg^27.30_11.20_0.00_0.00_0.00^38.50:Bar;700101;5101;2026-09-25T19:42:10.000Z;2026-09-25T19:42:11.000Z;ecdsa-plain-SHA256;utcTime;DEMO;DEMO"),
    ("tse-24-90", "V0;VH-BERLIN-KASSE-1;Kassenbeleg-V1;Beleg^16.40_8.50_0.00_0.00_0.00^24.90:Unbar;700102;5102;2026-09-25T20:05:44.000Z;2026-09-25T20:05:45.000Z;ecdsa-plain-SHA256;utcTime;DEMO;DEMO"),
    ("tse-61-00", "V0;VH-BERLIN-KASSE-1;Kassenbeleg-V1;Beleg^44.00_17.00_0.00_0.00_0.00^61.00:Unbar;700103;5103;2026-09-25T21:17:02.000Z;2026-09-25T21:17:03.000Z;ecdsa-plain-SHA256;utcTime;DEMO;DEMO"),
    ("tse-unknown-bar", "V0;OTHER-BAR-KASSE;Kassenbeleg-V1;Beleg^12.00_0.00_0.00_0.00_0.00^12.00:Bar;1;1;2026-09-25T18:00:00.000Z;2026-09-25T18:00:01.000Z;ecdsa-plain-SHA256;utcTime;DEMO;DEMO"),
    ("code-VH-3X9P-5T", "VH:VH-3X9P-5T"),
    ("code-VH-8N2D-6R", "VH:VH-8N2D-6R"),
    ("code-VH-TEST-01", "VH:VH-TEST-01"),
]

let context = CIContext()
for (name, payload) in receipts {
    let filter = CIFilter.qrCodeGenerator()
    filter.message = Data(payload.utf8)
    filter.correctionLevel = "M"
    guard let image = filter.outputImage?.transformed(by: CGAffineTransform(scaleX: 12, y: 12)),
          let cg = context.createCGImage(image, from: image.extent) else { continue }
    // white margin around the code
    let pad = 96
    let size = NSSize(width: cg.width + pad * 2, height: cg.height + pad * 2)
    let canvas = NSImage(size: size)
    canvas.lockFocus()
    NSColor.white.setFill()
    NSRect(origin: .zero, size: size).fill()
    NSGraphicsContext.current?.imageInterpolation = .none
    NSImage(cgImage: cg, size: NSSize(width: cg.width, height: cg.height))
        .draw(in: NSRect(x: pad, y: pad, width: cg.width, height: cg.height))
    canvas.unlockFocus()
    guard let tiff = canvas.tiffRepresentation, let rep = NSBitmapImageRep(data: tiff),
          let png = rep.representation(using: .png, properties: [:]) else { continue }
    try png.write(to: URL(fileURLWithPath: "\(outDir)/\(name).png"))
    print("wrote \(name).png")
}

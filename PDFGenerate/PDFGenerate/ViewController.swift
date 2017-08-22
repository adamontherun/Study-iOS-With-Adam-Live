//😘 it is 8/19/17

import UIKit
import PDFKit

class ViewController: UIViewController {

    var pdfView: PDFView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createPDF()
    }
    private func configureUI() {
        // create and add the PDF view
        pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func createPDF() {
        let page = PDFPage()
        let mediaBox = page.bounds(for: .artBox)
        
        
        
        
        let doc = PDFDocument()
        doc.insert(page, at: 0)
        pdfView.document = doc
    }
}


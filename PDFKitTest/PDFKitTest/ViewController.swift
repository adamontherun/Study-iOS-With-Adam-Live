//😘 it is 8/18/17

import UIKit
import PDFKit

class ViewController: UIViewController {
    
    var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        //loadProtectedPDF()
        loadPDF()
        configurePDFView()
        addObservers()
    }
    
    private func configureUI() {
        
        pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func loadProtectedPDF() {
        guard
            let url = Bundle.main.url(forResource: "got", withExtension: "pdf"),
            let document = PDFDocument(url: url)
            else { fatalError() }
        
        if document.isLocked && document.unlock(withPassword: "test") {
            
            if document.permissionsStatus == .owner {
                print("do owner stuff")
            }
            
            if document.allowsCopying { print("we can copy") }
            if document.allowsPrinting { print("we can print") }
            if document.allowsDocumentChanges { print("we can change") }
       
            
            
            pdfView.document = document
        } else {
            print("we've got a problem.")
        }
        
        
    }
    
    private func loadPDF() {
        guard
            let url = Bundle.main.url(forResource: "dec", withExtension: "pdf"),
            let document = PDFDocument(url: url)
            else { fatalError() }
        pdfView.document = document
    }
    
    private func configurePDFView() {
        pdfView.delegate =  self
       // pdfView.autoScales = true
        
        let bounds = CGRect(x: 10, y:10 , width: 100, height: 100)
        
        let widget = PDFAnnotation(bounds: bounds, forType: .widget, withProperties: nil)
        widget.widgetFieldType = .text
        widget.backgroundColor = .purple
        
//        let link = PDFAnnotation(bounds: bounds, forType: .link, withProperties: nil)
//        link.contents = "I'm an apple link"
//        let appleURL = URL(string: "http://apple.com")!
//        let actionURL = PDFActionURL(url: appleURL)
//        
//        link.action = actionURL
        
        //let line = PDFAnnotation(bounds: bounds, forType: .line, withProperties: nil)
//        line.setValue([0,0,100,100], forAnnotationKey: .linePoints)
//        line.setValue(["Closed", "Open"], forAnnotationKey: .lineEndingStyles)
//        line.setValue(UIColor.red, forAnnotationKey: .color)
//
//        line.startPoint = CGPoint(x: 10, y: 10)
//        line.endPoint = CGPoint(x: 100, y: 100)
//        line.startLineStyle = .closedArrow
//        line.endLineStyle = .openArrow
//        line.color = .green
        
//        let border = PDFBorder()
//        border.lineWidth = 2.0
//        line.border = border
        
        let page = pdfView.document?.page(at: 0)
        
        page?.addAnnotation(widget)
        
        
        //        pdfView.displayMode = .twoUpContinuous
        //        pdfView.displaysAsBook = true
        //  pdfView.autoScales =
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handlePageChange(notification:)), name: Notification.Name.PDFViewPageChanged, object: nil)
    }
    
    @objc private func handlePageChange(notification: Notification) {
        print("we changed pages")
    }
    
    @IBAction func handleNextButtonTapped(_ sender: Any) {
        pdfView.goToNextPage(nil)
    }
    @IBOutlet weak var handleCustomThingButtonTapped: UIBarButtonItem!
}

extension ViewController: PDFViewDelegate {
    
    func pdfViewWillClick(onLink sender: PDFView, with url: URL) {
        print(url)
    }
}


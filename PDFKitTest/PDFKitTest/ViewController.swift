//😘 it is 8/18/17

import UIKit
import PDFKit

class ViewController: UIViewController {
    
    var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
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
    
    private func loadPDF() {
        guard
            let url = Bundle.main.url(forResource: "toyManual", withExtension: "pdf"),
            let document = PDFDocument(url: url)
            else { fatalError() }
        pdfView.document = document
    }
    
    private func configurePDFView() {
        pdfView.delegate =  self
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


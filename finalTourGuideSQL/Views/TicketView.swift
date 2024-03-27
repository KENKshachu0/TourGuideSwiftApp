//
//  TicketView.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/27.
//

import SwiftUI
import PassKit
import CoreImage.CIFilterBuiltins

struct TicketView: View {
    let ticket: Ticket
    @State private var qrCodeImage: UIImage?
    
    var body: some View {
        VStack {
            Text("支付成功！")
                .font(.headline)
            Text("您的\(ticket.type)已准备好")
                .font(.title2)
            Text("票价: \(ticket.price)")
            
            if let qrCodeImage = qrCodeImage {
                Image(uiImage: qrCodeImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            }
            
            Button("添加到Wallet") {
                addToWallet()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .onAppear {
            qrCodeImage = generateQRCode(from: "Ticket: \(ticket.type), Price: \(ticket.price)")
        }
    }
    
    func addToWallet() {
        print("添加到Wallet成功")
    }
    
    // 二维码生成
    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        
        return UIImage()
    }
}

struct Ticket {
    var type: String
    var price: String
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView(ticket: Ticket(type: "成人票", price: "¥100"))
    }
}




//
//  ShoppingView.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/26.
//VStack{
//Image("background")
//            .resizable()
 //           .scaledToFill()
 //           .edgesIgnoringSafeArea(.all)
// }

import SwiftUI
import PassKit

struct ShoppingView: View {
    @State private var selectedTicketIndex = 0
    @State private var selectedTicket: Ticket?
    let tickets = [("成人票", 100), ("儿童票", 50), ("团体票", 80)]

    var body: some View {
        VStack(spacing: 20) {
            Text("选择门票类型")
                .font(.headline)
            
            Picker("门票类型", selection: $selectedTicketIndex) {
                ForEach(0..<tickets.count, id: \.self) {
                    Text(self.tickets[$0].0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            
            VStack {
                //Text("已选择: \(tickets[selectedTicketIndex].0)")
                Text("价格: ¥\(tickets[selectedTicketIndex].1)")
            }

            
            Button(action: {
                // 实际应用中调用支付
                print("模拟WeChat支付过程")
                let ticketInfo = tickets[selectedTicketIndex]
                selectedTicket = Ticket(type: ticketInfo.0, price: "¥\(ticketInfo.1)")
            }) {
                HStack {
                    Image(systemName: "dollarsign.circle")
                    Text("微信支付")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
            }
            Button(action: {
                // 实际应用中调用支付
                print("模拟支付Apple Pay过程")
                let ticketInfo = tickets[selectedTicketIndex]
                selectedTicket = Ticket(type: ticketInfo.0, price: "¥\(ticketInfo.1)")
            }) {
                HStack {
                    Image(systemName: "applelogo")
                    Text("Apple Pay")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                
                
            }
            if let selectedTicket = selectedTicket {
                TicketView(viewModel: TicketViewModel(ticket: selectedTicket))
            }
        }
        .padding()
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView()
    }
}


//#Preview {
//    ShoppingView()
//}

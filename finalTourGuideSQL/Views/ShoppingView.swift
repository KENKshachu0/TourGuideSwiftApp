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
import PassKit // PassKit用于Apple Pay

import SwiftUI

struct ShoppingView: View {
    @State private var selectedTicketIndex = 0
    let tickets = [("成人票", 100), ("儿童票", 50), ("家庭套票", 250)]

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
                print("模拟支付过程")
            }) {
                HStack {
                    Image(systemName: "creditcard.fill")
                    Text("支付")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
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

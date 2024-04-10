//
//  ShoppingView2.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/4/6.
//

import SwiftUI

struct ShoppingView2: View {
    @State private var shoppingList: [Product] = []
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    ShoppingSummaryView(shoppingList: shoppingList)
                        .padding()
                    
                    Spacer()
                }
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(products, id: \.id) { product in
                        NavigationLink(destination: ProductDetailView(product: product, addToCart: { selectedProduct in
                            shoppingList.append(selectedProduct)
                        })) {
                            ProductCardView(product: product)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("特产购物")
            
            
        }
    }
}

struct ProductCardView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .font(.title)
                .foregroundColor(.black)
                .padding(.bottom, 4)
            AsyncImageView(urlString: "https://s2.loli.net/2024/03/26/7xJZjXgoFzeMA8T.jpg")
            Text(product.description)
                .foregroundColor(.gray)
                .lineLimit(3)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ProductDetailView: View {
    let product: Product
    let addToCart: (Product) -> Void
    @State private var quantity: Int = 1
    
    var body: some View {
        VStack {
            Text(product.name)
                .font(.title)
                .padding()
            AsyncImageView(urlString: "https://s2.loli.net/2024/03/26/7xJZjXgoFzeMA8T.jpg")
            Text(product.description)
                .padding()
            
            Stepper(value: $quantity, in: 1...10) {
                Text("数量: \(quantity)")
            }
            .padding()
            
            Button(action: {
                let selectedProduct = Product(name: product.name, description: product.description)
                addToCart(selectedProduct)
            }) {
                Text("加入购物车")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .navigationTitle(product.name)
    }
}

struct ShoppingSummaryView: View {
    let shoppingList: [Product]
    
    var totalPrice: Double {
        let pricePerProduct = 10.0 // 每个产品的价格
        return Double(shoppingList.count) * pricePerProduct
    }
    
    var body: some View {
        VStack {
            Text("购物车")
                .font(.title)
                .padding()
            
            List {
                ForEach(shoppingList, id: \.id) { product in
                    Text("\(product.name)")
                }
            }
            
            Text("总价: \(totalPrice, specifier: "%.2f")元")
                .font(.headline)
                .padding()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}


struct Product: Identifiable {
    let id = UUID()
    let name: String
    let description: String
}

let products = [
    Product(name: "薰衣草", description: "薰衣草叶形花色优美典雅，蓝紫色花序颖长秀丽，特殊的香气气味醇厚、浓郁，有“芳香药草”之美誉，被称为“香草之后”，薰衣草用途广泛，功效强大，香气能醒脑明目安神，使人舒适，舒解焦虑，还能驱除蚊蝇，驱虫防蛀，还可直接代茶引用和药用"),
    Product(name: "红茶", description: "红茶的简介"),
    Product(name: "奶酪", description: "奶酪简介"),
    Product(name: "巧克力", description: "巧克力简介"),
    Product(name: "饼干", description: "饼干简介"),
    Product(name: "果酱", description: "果酱简介")
]




#Preview {
    ShoppingView2()
}

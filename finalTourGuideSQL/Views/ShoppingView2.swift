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
            AsyncImageView(urlString: product.productImage)
            Text(product.description)
                .padding()
            
            Stepper(value: $quantity, in: 1...10) {
                Text("数量: \(quantity)")
            }
            .padding()
            
            Button(action: {
                let selectedProduct = Product(name: product.name, description: product.description, productImage: product.productImage)
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
        let pricePerProduct = 68.0 // 产品价格
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
    let productImage: String
}

let products = [
    Product(name: "薰衣草", description: "薰衣草叶形花色优美典雅，蓝紫色花序颖长秀丽，特殊的香气气味醇厚、浓郁，有“芳香药草”之美誉，被称为“香草之后”，薰衣草用途广泛，功效强大，香气能醒脑明目安神，使人舒适，舒解焦虑，还能驱除蚊蝇，驱虫防蛀，还可直接代茶引用和药用", productImage: "https://s2.loli.net/2024/04/13/CIAlEgD3P9fcW.png"),
    Product(name: "无刺红花", description: "裕民无刺红花是一种油、药、饲料、天然色素、染料兼用的经济作物，据检测，从红花籽中提取出的红花油内的亚油酸、维生素含量较高，被誉为世界上三大保健功能营养油之一，红花花丝是一种名贵的中药材，广泛用于治疗冠心病、心绞痛和心肌梗塞。裕民种植的无刺红花籽所产的纯红花籽油中亚油酸含量高达83%，被誉为“亚油酸之王”。", productImage: "https://s2.loli.net/2024/04/13/CIAlEgD8P9fcW.png"),
    Product(name: "巴什拜羊", description: "巴什拜羔羊从初生到120日龄的哺乳期间，公羔平均日增重为275～344 g，母羔平均日增重为250～338 g。巴什拜羊是塔城地区优良地方品种，属脂臀型粗毛绵羊品种，具有适应性强,抗病力强,产肉性能好（4～5月龄羔羊胴体重可以达18 kg，屠宰率高达56%，骨肉比可达1:4）等优点。", productImage: "https://s2.loli.net/2024/04/13/CIAlEgD3n9fcW.png"),
    Product(name: "巧克力", description: "巧克力简介", productImage: "https://s2.loli.net/2024/04/13/CIAlEgD3n9fcW.png"),
    Product(name: "饼干", description: "饼干简介", productImage: "https://s2.loli.net/2024/04/13/CIAlEgD3n8fcW.png"),
    Product(name: "果酱", description: "果酱简介", productImage: "https://s2.loli.net/2024/04/13/CIAlEgD3n8fcW.png")
]




#Preview {
    ShoppingView2()
}

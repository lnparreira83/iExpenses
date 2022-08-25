//
//  ResumoHomeView.swift
//  iExpenses
//
//  Created by Lucas Parreira on 11/07/21.
//

import SwiftUI

struct Dashboard: View {
    @FetchRequest(entity:Despesas.entity(),sortDescriptors:[])
    var despesas:FetchedResults<Despesas>
    
    @FetchRequest(entity:Recebidos.entity(),sortDescriptors:[])
    var recebidos:FetchedResults<Recebidos>
    
    var somaDespesas: Double {
        despesas.reduce(0) { $0 + $1.valor}
    }
    
    var somaRecebidos: Double {
        recebidos.reduce(0) { $0 + $1.valor}
    }
    
    @State var currentTab = "Receitas"
    @State var checkReceita = false
    @Namespace var animation
    @State var showingAlert = false
    
    var body: some View {
        NavigationView{
            
            VStack{
                    
                 VStack{
                        
//                        Text("Resumo das despesas")
//                            .font(.title)
//                            .fontWeight(.heavy)
//                            .foregroundColor(.white)
//                            .frame(maxWidth:.infinity,alignment: .leading)
//                            .padding(.leading)
//                        // Custom Segment Picker...
                        
                        HStack{
                            Text("Recebidos")
                                .fontWeight(.bold)
                                .padding(.vertical,12)
                                .padding(.horizontal, 25)
                                .background(
                                    ZStack{
                                        if currentTab == "Despesas" {
                                            Color.white.cornerRadius(10)
                                                .matchedGeometryEffect(id: "TAB", in: animation)
                                        }
                                    }
                                )
                                .foregroundColor(currentTab == "Receitas" ? .white : .black)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                        currentTab = "Despesas"
                                        self.checkReceita.toggle()
                                    }
                                }
                            
                            Text("Despesas")
                                .fontWeight(.bold)
                                .padding(.vertical,12)
                                .padding(.horizontal, 25)
                                .background(
                                    ZStack{
                                        if currentTab == "Receitas" {
                                            Color.white.cornerRadius(10)
                                                .matchedGeometryEffect(id: "TAB", in: animation)
                                        }
                                    }
                                )
                                .foregroundColor(currentTab == "Despesas" ? .white : .black)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                        currentTab = "Receitas"
                                        self.checkReceita.toggle()
                                    }
                                }
                        }
                        .padding(.vertical,7)
                        .padding(.horizontal,10)
                        .background(Color.black.opacity(0.35))
                        .cornerRadius(10)
                        .padding(.top,20)
                        
                        // Money View...
                        
                        HStack(spacing:5){
                            ZStack{
                                Circle()
                                    .stroke(Color.white.opacity(0.1),lineWidth: 5)

                                let progress = somaDespesas - somaRecebidos

                                Circle()
                                    .trim(from: 0, to: CGFloat(progress))
                                    .stroke(Color.yellow, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                                    .rotationEffect(.init(degrees: -90))
                                
                                Image(systemName: "dollarsign.square.fill")
                                    .font(.system(size: 55, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 110)
                            .padding(.bottom,10)
                            .padding(.leading,15)
                            
                            if checkReceita == true {
                            
                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text("Recebidos")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white.opacity(0.6))
                                    
                                    Text("R$\(somaRecebidos,specifier: "%.2f")")
                                        .font(.system(size: 25))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
//                                    Text("Maximo")
//                                        .fontWeight(.bold)
//                                        .foregroundColor(Color.white.opacity(0.6))
//                                        .padding(.top,10)
//
//                                    Text("R$...")
//                                        .font(.system(size: 25))
//                                        .fontWeight(.bold)
//                                        .foregroundColor(.white)
                                })
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading,30)
                            } else {
                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text("Despesas")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white.opacity(0.6))
                                    
                                    Text("R$\(somaDespesas,specifier: "%.2f")")
                                        .font(.system(size: 25))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
//                                    Text("Maximo")
//                                        .fontWeight(.bold)
//                                        .foregroundColor(Color.white.opacity(0.6))
//                                        .padding(.top,10)
//                                    
//                                    Text("R$...")
//                                        .font(.system(size: 25))
//                                        .fontWeight(.bold)
//                                        .foregroundColor(.white)
                                })
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading,30)
                            }
                        }
                        
                        VStack{
                            Capsule()
                                .fill(Color.gray)
                                .frame(width: 100, height: 2)
                            
                            HStack(spacing:15){
                                VStack(alignment:.leading, spacing: 10){
                                    Text("Seu saldo")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                
                                }
                                
                                Spacer(minLength: 0)
                                
                                Button(action: shareButton){
                                    Image(systemName: "square.and.arrow.up.fill")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                }
                                .offset(x:-10)
                            }
                            .padding(.top,8)
                            .padding()
                            
                            HStack{
                                if somaRecebidos > somaDespesas {
                                    Text("R$\(somaRecebidos - somaDespesas,specifier:"%.2f")")
                                        .font(.title)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.blue)
                                } else {
                                    Text("R$\(somaRecebidos - somaDespesas,specifier:"%.2f")")
                                        .font(.title)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.red)
                                }
                                    
                                
                                Spacer(minLength: 0)
                                
//                                if somaRecebidos > somaDespesas {
//                                    Image(systemName: "arrow.up.heart.fill")
//                                        .foregroundColor(.blue)
//                                } else {
//                                    Image(systemName: "arrow.down.heart.fill")
//                                        .foregroundColor(.gray)
//                                }
                            
                            }
                            .padding(.leading,15)
                            .onTapGesture {
                                let pasteboard = UIPasteboard.general
                                pasteboard.string = String(somaRecebidos - somaDespesas)
                                showingAlert = true
                            }
                            .alert(isPresented: $showingAlert) {
                                        Alert(title: Text("Saldo copiado com sucesso!"), message: Text(""), dismissButton: .default(Text("OK")))
                                    }
                      
                        
                        }
                        .frame(maxWidth: .infinity, maxHeight: 170, alignment: .top)
                        .padding([.horizontal,.top])
                        .background(Color.white
                                        .clipShape(CustomShape(corners: [.topLeft,.topRight], radius: 35))
                                        .ignoresSafeArea(.all, edges: .bottom))
                        
                        .padding(.top,10)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                 .background(Color.gray.opacity(0.20))
                 .border(Color.black, width: 0.3)
                 .cornerRadius(8)
                 .shadow(color: .blue, radius: 8, x: 0, y: 0)
                    
            }
            .navigationBarTitle("Resumo das Despesas",displayMode: .inline)
        }
    }
    
    func shareButton(){
        let url = String(somaRecebidos - somaDespesas)
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}

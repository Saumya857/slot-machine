//
//  ContentView.swift
//  slot-machine
//
//  Created by Saumya Singh on 02/03/24.
//

import SwiftUI

struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let p1 = CGPoint(x: 0, y: 20)
            let p2 = CGPoint(x: 0, y: rect.height-20)
            let p3 = CGPoint(x: rect.width/2, y: rect.height)
            let p4 = CGPoint(x: rect.width, y: rect.height-20)
            let p5 = CGPoint(x: rect.width, y: 20)
            let p6 = CGPoint(x: rect.width/2, y: 0)
            
            path.move(to: p6)
            
            path.addArc(tangent1End: p1, tangent2End: p2, radius: 15)
            path.addArc(tangent1End: p2, tangent2End: p3, radius: 15)
            path.addArc(tangent1End: p3, tangent2End: p4, radius: 15)
            path.addArc(tangent1End: p4, tangent2End: p5, radius: 15)
            path.addArc(tangent1End: p5, tangent2End: p6, radius: 15)
            path.addArc(tangent1End: p6, tangent2End: p1, radius: 15)
        }
    }
    
}

enum Choice: Int, Identifiable {
    
    var id: Int {
        rawValue
    }
    
    case success, failure
}

struct ContentView: View {
    
    @State public var symbols = ["eating","happy","love","scary","sleeping"]
    @State public var number = [0,1,2]
    @State public var counter = 0
    @State private var showingAlerts: Choice?
    
    var body: some View {
        ZStack{
            Image("sunshine")
                .resizable()
                .ignoresSafeArea(.all)
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 80){
                HStack{
                    Image("fire")
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .orange, radius: 1,y: 3)
                    Text("SLOT MACHINE")
                        .font(.system(size: 35))
                        .fontWeight(.black)
                        .scaledToFill()
                        .shadow(color: .orange, radius: 1,y: 3)
                    Image("fire")
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .orange, radius: 1,y: 3)
                }
                
                    Text("Attemps left : \(counter)")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                    .font(.system(.caption))
                
                    VStack(spacing: 15){
                        HStack(spacing: 35){
                            Hexagon()
                                .fill(Color.white.opacity(0.7))
                                .frame(width: 100,height: 120,alignment: .center)
                                .overlay(
                                    Image(symbols[number[0]])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80,height: 80,alignment: .center)
                                        .shadow(color: .gray, radius: 2,x: 4,y: 5)
                                )
                                .shadow(color: .gray,radius: 5,y: 5)
                            Hexagon()
                                .fill(Color.white.opacity(0.7))
                                .frame(width: 100,height: 120,alignment: .center)
                                .overlay(
                                    Image(symbols[number[1]])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80,height: 80,alignment: .center)
                                        .shadow(color: .gray, radius: 2,x: 4,y: 5)
                                )
                                .shadow(color: .gray,radius: 5,y: 5)
                        }
                        Hexagon()
                            .fill(Color.white.opacity(0.7))
                            .frame(width: 100,height: 120,alignment: .center)
                            .overlay(
                                Image(symbols[number[2]])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80,height: 80,alignment: .center)
                                    .shadow(color: .gray, radius: 2,x: 4,y: 5)
                            )
                            .shadow(color: .gray,radius: 5,y: 5)
                        HStack(spacing: 35){
                            Hexagon()
                                .fill(Color.white.opacity(0.7))
                                .frame(width: 100,height: 120,alignment: .center)
                                .overlay(
                                    Image(symbols[number[0]])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80,height: 80,alignment: .center)
                                        .shadow(color: .gray, radius: 2,x: 4,y: 5)
                                )
                                .shadow(color: .gray,radius: 5,y: 5)
                            Hexagon()
                                .fill(Color.white.opacity(0.7))
                                .frame(width: 100,height: 120,alignment: .center)
                                .overlay(
                                    Image(symbols[number[1]])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80,height: 80,alignment: .center)
                                        .shadow(color: .gray, radius: 2,x: 4,y: 5)
                                )
                                .shadow(color: .gray,radius: 5,y: 5)
                        }
                        
                    }
                Button{
                    self.number[0] = Int.random(in: 0...symbols.count-1)
                    self.number[1] = Int.random(in: 0...symbols.count-1)
                    self.number[2] = Int.random(in: 0...symbols.count-1)
                    
                    counter+=1
                    
                    if self.number[0] == self.number[1] && self.number[1]==self.number[2] && counter <= 5{
                        self.showingAlerts = .success
                        counter=0
                    }
                    
                    if counter > 5{
                        self.showingAlerts = .failure
                        counter=0
                    }
                }
            label: {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 250,height: 50,alignment: .center)
                    .foregroundColor(.color)
                    .overlay(
                        Text("Spin")
                            .font(.system(size: 30))
                            .frame(width: 100,height: 40,alignment: .center)
                            .fontWeight(.black)
                            .shadow(color: .gray, radius: 1)
                    )
                    .shadow(color: .gray, radius: 2,y: 5)
            }
            }
            .alert(item: $showingAlerts){alert -> Alert in
                switch alert{
                case .success:
                    Alert(title: Text("Yahhh you won"), message: Text("Born with a charm"), dismissButton: .cancel())
                case .failure:
                    Alert(title: Text("Ooopppss"), message: Text("Better luck next time"), dismissButton: .cancel())
            }
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//  MView.swift
//  Beer
//
//  Created by Álvaro San Valero Benito on 20/12/23.
//

import SwiftUI

struct MView: View {
    @EnvironmentObject var beermodel: BeerModel
    
    @State private var showListManufacturerView = false
    @State private var selectedManufacturerType: String = ""
    
    var body: some View {
        ZStack{
            // Fondo color cerveza
            Color(red: 255 / 255, green: 212 / 255, blue: 94 / 255)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Drink me")
                    .font(.custom("", fixedSize: 65))
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .frame(width: 300.0, height: 0.0)
                
                Spacer().frame(height: 50)
                
                // Icono que representa cervezas (modificado)
                Image(systemName: "beer.mug.fill")
                    .font(.custom("",fixedSize: 150))
                    .frame(width: 300, height: 150)
                
                Spacer().frame(height: 150)
                
                HStack(){
                    // IMPORTADAS con fondo negro
                    Text("IMPORTADAS")
                        .background(RoundedRectangle(cornerRadius: 25)
                            .fill(Color.black)
                            .frame(width: 150, height: 250)
                            .onTapGesture {
                                selectedManufacturerType = "IMPORTADAS"
                                showListManufacturerView.toggle()
                            })
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 25.0)

                    Spacer()
                    
                    // NACIONALES con fondo negro
                    Text("NACIONALES")
                        .background(RoundedRectangle(cornerRadius: 25)
                            .fill(Color.black)
                            .frame(width: 150, height: 250)
                            .onTapGesture {
                                selectedManufacturerType = "NACIONALES"
                                showListManufacturerView.toggle()
                            })
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 25.0)
                }.padding(.horizontal, 25.0)
                
            }
        }
        .fullScreenCover(isPresented: $showListManufacturerView , content: {
            ManufacturerDetailView(title: selectedManufacturerType)
        })
        
    }
}

struct MView_Previews: PreviewProvider {
    static var previews: some View {
        MView().environmentObject(BeerModel())
    }
}

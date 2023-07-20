//
//  OnBoardingPage.swift
//  Estore
//
//  Created by Denys on 1/4/23.
//

import SwiftUI

struct OnBoardingPage: View {
    //Showing Login Page...
    @State var showLoginPage: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            Text("Find your \nGadget")
                .font(.system(size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Image("landing-page")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button {
                withAnimation {
                    showLoginPage = true
                }
            }label: {
                Text("Get started")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical,18)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("Purple"))
            }
            .padding(.horizontal,30)
            //Addind Some Adjuxtments only for larger displays...
            
            .offset(y: getRect().height < 750 ? 20 : 50 )
            
            Spacer()
        }
        .padding()
        .padding(.top, getRect().height < 750  ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            
        Color("Purple")
        )
        .overlay(
            Group {
                if showLoginPage {
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
      
    }
}
//Extending View to get Screen Bounds ...
extension View {
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
}

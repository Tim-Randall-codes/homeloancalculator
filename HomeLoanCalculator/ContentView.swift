//
//  ContentView.swift
//  HomeLoanCalculator
//
//  Created by Tim Randall on 25/9/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Background()
                VStack{
                    Text("Option one: Enter principal, years and rate to find out total interest paid and monthly repayments.").padding()
                    NavigationLink(destination: PrincipalnYears()){
                        buttons(input: "Start option one")
                    }
                    Text("Option two: Enter your desired monthly repayment amount, years and rate to find out how much you are able to borrow (principal), as well as how much interest you will have to pay.").padding()
                    NavigationLink(destination: MonthlyRepay()){
                        buttons(input: "Start option two")
                    }
                }.navigationTitle("Home Loan Calculator")
            }
        }
    }
}

struct PrincipalnYears: View {
    var body: some View {
        ZStack{
            Background()
            VStack{
                Text("hello world").padding()
            }.navigationTitle("Principal")
        }
    }
}

struct MonthlyRepay: View {
    var body: some View {
        ZStack{
            Background()
            VStack{
                Text("Hello world").padding()
            }.navigationTitle("Monthlies")
        }
    }
}

struct buttons: View {
    var input: String = ""
    var body: some View {
        Text(input)
            .padding()
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(15)
    }
}

struct Background: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.white, .yellow]),
                                          startPoint: .topLeading,
                                          endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
                        buttons(input: "Start Option One")
                    }
                    Text("Option two: Enter your desired monthly repayment amount, years and rate to find out how much you are able to borrow (principal), as well as how much interest you will have to pay.").padding()
                    NavigationLink(destination: MonthlyRepay()){
                        buttons(input: "Start Option Two")
                    }
                }.navigationTitle("Home Loan Calculator")
            }
        }
    }
}

struct PrincipalnYears: View {
    @State var principalString: String = ""
    @State var rateString: String = ""
    @State var yearsString: String = ""
    @State var principal: Float = 0
    @State var rate: Float = 0
    @State var years: Float = 0
    @State var total: Float = 0
    @State var interest: Float = 0
    @State var monthly: Float = 0
    @State  var displayMessage: String = ""
    @State var letCalculate: Bool = true
    var body: some View {
        ZStack{
            Background()
            VStack{
                Text(displayMessage).padding()
                Results(total: total, interest: interest, monthly: monthly)
                HStack {
                    Text("Principal: ").padding()
                    TextField("Enter your principal here", text: $principalString).padding()
                }
                HStack {
                    Text("Interest (%): ").padding()
                    TextField("Enter your interest rate here", text: $rateString).padding()
                }
                HStack {
                    Text("Years: ").padding()
                    TextField("Enter your amount of years here", text: $yearsString).padding()
                }
                Spacer()
                Button(action: {
                    principal = checkInput(stringVariable: principalString)
                    rate = checkInput(stringVariable: rateString)
                    years = checkInput(stringVariable: yearsString)
                    if letCalculate == true {
                        displayMessage = ""
                        rate /= 100
                        total = interestFormula(p: principal, n: years, r: rate)
                        interest = total - principal
                        monthly = total / (years * 12)
                    }
                }, label: {
                    buttons(input: "Calculate")
                })
                Button(action: {
                    principalString = ""
                    rateString = ""
                    yearsString = ""
                    principal = 0
                    rate = 0
                    years = 0
                    total = 0
                    interest = 0
                    monthly = 0
                    displayMessage = ""
                }, label: {
                    buttons(input: "Clear")
                })
                Spacer()
            }.navigationTitle("Principal")
        }
    }
    func interestFormula(p: Float, n: Float, r: Float) -> Float {
        var t: Float = 0
        t = pow(p * (1 + r), n)
        return t
    }
    func checkInput (stringVariable: String) -> Float {
        let floatOutput: Float = Float(stringVariable) ?? 0
        if floatOutput == 0 {
            displayMessage = "Please enter only numbers greater than zero into all three fields"
            letCalculate = false
        }
        else {
            letCalculate = true
        }
        return floatOutput
    }
}

struct MonthlyRepay: View {
    @State var monthlyString: String = ""
    @State var rateString: String = ""
    @State var yearsString: String = ""
    @State var monthly: Float = 0
    @State var rate: Float = 0
    @State var years: Float = 0
    @State var total: Float = 0
    @State var interest: Float = 0
    @State var principal: Float = 0
    @State  var displayMessage: String = ""
    @State var letCalculate: Bool = true
    var body: some View {
        ZStack{
            Background()
            VStack{
                Text(displayMessage).padding()
                Results(total: total, interest: interest, monthly: monthly)
                Text("The principal's amount is: \(principal)")
                HStack{
                    Text("Monthly payment: ").padding()
                    TextField("Enter your desired monthly", text: $monthlyString)
                }
                HStack{
                    Text("Interest rate: ").padding()
                    TextField("Enter the interest rate here", text: $rateString)
                }
                HStack{
                    Text("Years: ").padding()
                    TextField("Enter the amount of years here", text: $yearsString)
                }
                Button(action: {
                    rate = checkInput(stringVariable: rateString)
                    years = checkInput(stringVariable: yearsString)
                    monthly = checkInput(stringVariable: monthlyString)
                    if letCalculate == true {
                        displayMessage = ""
                        rate = (rate / 12)/100
                        years = years * 12
                        total = calculateTotal(m: monthly, n: years)
                        principal = calculatePrincipal(t: total, r: rate, n: years)
                        interest = total - principal
                    }
                }, label: {
                    buttons(input: "Calculate")
                })
                Button(action: {
                    monthlyString = ""
                    rateString = ""
                    yearsString = ""
                    principal = 0
                    rate = 0
                    years = 0
                    total = 0
                    interest = 0
                    monthly = 0
                    displayMessage = ""
                }, label: {
                    buttons(input: "Clear")
                })
            }.navigationTitle("Monthlies")
        }
    }
    func checkInput (stringVariable: String) -> Float {
        let floatOutput: Float = Float(stringVariable) ?? 0
        if floatOutput == 0 {
            displayMessage = "Please enter only numbers greater than zero into all three fields"
            letCalculate = false
        }
        else {
            letCalculate = true
        }
        return floatOutput
    }
    func calculateTotal (m: Float, n: Float) -> Float {
        var total: Float = 0
        total = m * n
        return total
    }
    func calculatePrincipal (t: Float, r: Float, n: Float) -> Float {
        var principal: Float = 0
        principal = t / pow(1 + r, n)
        return principal
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

struct Results: View {
    var total: Float
    var interest: Float
    var monthly: Float
    var body: some View {
        Text("The total paid is: \(String(format: "%.2f",total)).").padding()
        Text("The interest paid is: \(String(format: "%.2f",interest))").padding()
        Text("The monthly repayment is: \(String(format: "%.2f",monthly))").padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

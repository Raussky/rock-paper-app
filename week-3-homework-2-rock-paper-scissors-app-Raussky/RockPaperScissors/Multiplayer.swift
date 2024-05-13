//
//  Multiplayer.swift
//  RockPaperScissors
//
//  Created by Admin on 15.04.2023.
//

import SwiftUI

enum ScreenState2 {
    case choose
    case change
    case showOponent
    case openentChoose
    case game
}


struct MultiplayerSecond: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var screenState: ScreenState2 = .choose
    @State var selfChoice: Choices = .paper
    @State var oponentChoice: Choices = .random()
    
    var body: some View {
        VStack {
            switch screenState {
            case .choose:
                Player1Choose(selfChoice: $selfChoice, screenState: $screenState)
            case .change:
                Player1Change(choice: $selfChoice, screenState: $screenState)
            case .showOponent:
                Player2Wait(screenState: $screenState)
            case .openentChoose:
                Player2Choice(choice: $selfChoice,screenState: $screenState, oponentChoice: $oponentChoice)
            case .game:
                MultiplayerGame(selfChoice: $selfChoice, screenState: $screenState, oponentChoice: $oponentChoice)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem (placement: .navigationBarLeading)  {
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(red: 0.4, green: 0.31, blue: 0.64))
                        .bold()
                })
            }
        })
    }
}

struct Player1Choose: View {
    @Binding var selfChoice: Choices
    @Binding var screenState: ScreenState2
    @State private var round = 1
    @State private var playerScore = 0
    @State private var opponentScore = 0
    var body: some View {
        VStack(spacing: 25){
            Text("Take your pick")
            .font(.system(size: 54, weight: .bold, design: .default))
            .padding(.top,80)
            Text("Player1 • Score \(playerScore):\(opponentScore)")
                .font(.headline)
                .foregroundColor(Color(red: 103/255, green: 80/255, blue: 164/255))
                .padding(.bottom,50)
            ZStack{
                RoundedRectangle(cornerRadius: 48)
                    .foregroundColor(Color(red: 243/255, green: 242/255, blue: 248/255))
                    .frame(height: 128)
                Image("paper")
                .onTapGesture {
                    withAnimation(.linear(duration: 0.2)){
                        selfChoice = .paper
                        screenState = .change
                    }
                }
            }
            ZStack{
                RoundedRectangle(cornerRadius: 48)
                    .foregroundColor(Color(red: 243/255, green: 242/255, blue: 248/255))
                    .frame(height: 128)
                Image("scissors")
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.2)){
                            selfChoice = .scissors
                            screenState = .change
                        }
                    }
            }
            ZStack{
                RoundedRectangle(cornerRadius: 48)
                    .foregroundColor(Color(red: 243/255, green: 242/255, blue: 248/255))
                    .frame(height: 128)
                Image("rock")
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.2)){
                            selfChoice = .rock
                            screenState = .change
                        }
                    }
            }
        }
        .navigationTitle("Round #\(round)")
        .padding()
        .padding(.bottom,120)
    }
}

struct Player1Change: View {
    @State private var round = 1
    @State private var playerScore = 0
    @State private var opponentScore = 0
    @Binding var choice: Choices
    @Binding var screenState: ScreenState2
    var body: some View {
        VStack(spacing:20){
            Text("Your pick")
            .font(.system(size: 54, weight: .bold, design: .default))
            .padding(.top,50)
            Text("Player1 • Score \(playerScore):\(opponentScore)")
                .font(.headline)
                .foregroundColor(Color(red: 103/255, green: 80/255, blue: 164/255))
                .padding(.bottom,50)
            Spacer()
            ZStack{
                RoundedRectangle(cornerRadius: 48)
                    .foregroundColor(Color(red: 243/255, green: 242/255, blue: 248/255))
                    .frame(height: 128)
                Text(choice.image)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            screenState = .showOponent
                        }
                    }
            }
            Spacer()
            Button {
                withAnimation(.spring()) {
                    screenState = .choose
                    
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(red: 103/255, green: 80/255, blue: 164/255))
                    Text("I changed my mind")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .frame(height: 55)
            }
            .padding(.bottom,30)
        }
        .navigationTitle("Round #\(round)")
        .padding([.leading,.trailing],16)
    }
}

struct Player2Wait: View {
    @State private var round = 1
    @Binding var screenState: ScreenState2
    @State var rotation: Double = 360
    var body: some View {
        VStack(spacing: 20){
            Text("Pass the phone to your opponent")
                .font(.system(size: 54, weight: .bold, design: .default))
                .padding(.top,40)
                .multilineTextAlignment(.center)
            Spacer()
            
            Button(action: {
                withAnimation(.default) {
                    screenState = .openentChoose
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(red: 103/255, green: 80/255, blue: 164/255))
                    Text("Ready to continue")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .frame(height: 50)
            })
            .padding(.bottom,20)
        }
            .navigationTitle("Round #\(round)")
            .padding([.leading,.trailing],16)
    }
}

struct Player2Choice: View {
    @State private var playerScore = 0
    @State private var opponentScore = 0
    @State private var round = 1
    @Binding var choice: Choices
    @Binding var screenState: ScreenState2
    @Binding var oponentChoice: Choices
    var body: some View {
        VStack(spacing: 25){
            Text("Your pick")
                .font(.system(size: 54, weight: .bold, design: .default))
                .padding(.top,0)
            Text("Player2 • Score \(playerScore):\(opponentScore)")
                .font(.headline)
                .foregroundColor(Color(red: 103/255, green: 80/255, blue: 164/255))
                .padding(.bottom,50)
            ZStack{
                RoundedRectangle(cornerRadius: 48)
                    .foregroundColor(Color(red: 243/255, green: 242/255, blue: 248/255))
                    .frame(height: 128)
                Image("paper")
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.2)){
                            oponentChoice = .paper
                            screenState = .game
                        }
                    }
            }
            ZStack{
                RoundedRectangle(cornerRadius: 48)
                    .foregroundColor(Color(red: 243/255, green: 242/255, blue: 248/255))
                    .frame(height: 128)
                Image("scissors")
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.2)){
                            oponentChoice = .scissors
                            screenState = .game
                        }
                    }
            }
            ZStack{
                RoundedRectangle(cornerRadius: 48)
                    .foregroundColor(Color(red: 243/255, green: 242/255, blue: 248/255))
                    .frame(height: 128)
                Image("rock")
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.2)){
                            oponentChoice = .rock
                            screenState = .game
                        }
                    }
            }
            .padding(.bottom,50)
            .navigationTitle("Round #\(round)")
            .padding([.leading,.trailing],16)
        }
    }
}
    
    
    
    
    struct MultiplayerGame: View {
        @State private var round = 1
        @State private var playerScore = 0
        @State private var opponentScore = 0
        @Binding var selfChoice: Choices
        @Binding var screenState: ScreenState2
        @Binding var oponentChoice: Choices
        
        
        func ans() -> Int{
            if(selfChoice == oponentChoice){
                
                return 1
                
                
            }else if(selfChoice == Choices.rock && oponentChoice == Choices.scissors ){
                playerScore += 1
                return 2
                
                
            }else if(selfChoice == Choices.paper && oponentChoice == Choices.rock){
                playerScore += 1
                return 2
                
            }else if(selfChoice == Choices.scissors && oponentChoice == Choices.paper){
                playerScore += 1
                return 2
            }else {
                opponentScore += 1
                return 3
            }
        }
        var body: some View {
            VStack(spacing: 20) {
                VStack{
                    if(ans() == 1){
                        LinearGradient(
                            gradient: Gradient(
                                colors: [Color(red: 255/255, green: 204/255, blue: 0/255),Color(red: 255/255, green: 92/255, blue: 0/255)]
                            ),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(Text("Tie!")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 54, weight: .bold))
                            .padding(.top,12)
                        )
                        Text("Score \(playerScore):\(opponentScore)")
                            .font(.headline)
                            .foregroundColor(Color(red: 103/255, green: 80/255, blue: 164/255))
                            .padding(.top,20)
                    }else if(ans() == 2){
                        LinearGradient(
                            gradient: Gradient(
                                colors: [Color(red: 181/255, green: 238/255, blue: 155/255),Color(red: 36/255, green: 174/255, blue: 67/255)]
                            ),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(Text("Win!")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 54, weight: .bold))
                            .padding(.top,12)
                        )
                        Text("Score 1:0")
                            .font(.headline)
                            .foregroundColor(Color(red: 103/255, green: 80/255, blue: 164/255))
                            .padding(.top,20)
                    }else{
                        LinearGradient(
                            gradient: Gradient(
                                colors: [Color(red: 255/255, green: 105/255, blue: 97/255),Color(red: 253/255, green: 77/255, blue: 77/255)]
                            ),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(Text("Lose!")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 54, weight: .bold))
                            .padding(.top,12)
                        )
                        Text("Score 0:1")
                            .font(.headline)
                            .foregroundColor(Color(red: 103/255, green: 80/255, blue: 164/255))
                            .padding(.top,0)
                    }
                }
                .padding(.bottom,110)
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 48)
                            .frame(width: 198, height: 128)
                            .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.97))
                        Text("\(selfChoice.image)")
                            .frame(height: 80)
                            .font(.system(size: 80, weight: .medium))
                    }.overlay(ZStack {
                        RoundedRectangle(cornerRadius: 48)
                            .frame(width: 198, height: 128)
                            .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.97))
                            .overlay(
                                RoundedRectangle(cornerRadius: 48)
                                    .stroke(.white, lineWidth: 10)
                            )
                        Text("\(oponentChoice.image)")
                            .frame(height: 80)
                            .font(.system(size: 80, weight: .medium))
                    }
                        .offset(x: 150, y: 74)
                        .frame(width: 198, height: 128), alignment: .bottomTrailing
                    )
                    .padding(.trailing, 150)
                }
                .padding(.bottom,250)
                
                Button(action: {
                    screenState = .choose
                }){
                    Text("Another round")
                        .foregroundColor(Color.white)
                }
                .frame(width: 358, height: 50)
                .background(Color(red: 103/255, green: 80/255, blue: 164/255))
                .cornerRadius(8)
                .padding(.bottom, 40)
                
            }
        }
    }
    

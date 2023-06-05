//
//  DefaultProjectApp.swift
//  DefaultProject
//
//  Created by CycTrung on 04/06/2023.
//

import SwiftUI
import Firebase
import GoogleMobileAds

@main
struct DefaultProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            RootView().preferredColorScheme(.dark)
        }
    }
}

struct RootView: View {
    @StateObject var appController = APPCONTROLLER.shared
    @StateObject var user = User.shared
    @StateObject var coordinator = Coordinator.shared
    @StateObject var alerter: Alerter = Alerter.shared
    @AppStorage("FIRST_LOAD_APP") var FIRST_LOAD_APP = false

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            Group{
                if appController.SHOW_OPEN_APPP{
                    ZStack{
                        Image("AppIconSingle")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.background2)
                    .overlay(alignment: .bottom) {
                        //https://lottiefiles.com/9329-loading
                        LottieView(name: "loading_default", loopMode: .loop)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                    }
                }
                else{
                    ContentView()
                }
            }
            .environmentObject(appController)
            .environmentObject(user)
            .environmentObject(coordinator)
            .environmentObject(alerter)
            .navigationBarHidden(true)
            .navigationDestination(for: Page.self) { page in
                coordinator.build(page: page)
            }
            .sheet(item: $coordinator.sheet) { sheet in
                coordinator.build(sheet: sheet)
            }
            .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreencover in
                coordinator.build(fullScreenCover: fullScreencover)
            }
            .onAppear(perform: {
                if !appController.SHOW_OPEN_APPP{
                    return
                }
                CONSTANT.SHARED.load {
                    appController.SHOW_OPEN_APPP = true
                    self.openApp()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        withAnimation {
                            appController.SHOW_OPEN_APPP = false
                        }
                    })
                }
            })
            .onChange(of: appController.INDEX_TABBAR, perform: { b in
                if User.isShowInterstitial() == false{
                    return
                }
                appController.COUNT_INTERSTITIAL += 1
                if appController.COUNT_INTERSTITIAL % CONSTANT.SHARED.ADS.INTERVAL_INTERSTITIAL == 0{
                    InterstitialAd.shared.show()
                }
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { (output) in
                if User.isShowRate(){
                    MyAlert.showRate()
                }
                else{
                    if User.isShowAdsOpen(){
                        AdsOpenAd.shared.show()
                    }
                }
            }
            .alert(isPresented: $alerter.isShowingAlert) {
                alerter.alert ?? Alert(title: Text(""))
            }
        }
    }
    
    func openApp(){
        User.shared.getUser()
        GADMobileAds.sharedInstance().start(completionHandler: {_ in
            GADMobileAds.sharedInstance().applicationMuted = true
        })
    }
}


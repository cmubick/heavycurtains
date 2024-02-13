//
//  ContentView.swift
//  heavycurtains
//
//  Created by Chris Ubick on 11/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var addRecordingName: String = ""

    @State var addRecording = false
    
    @ObservedObject var vm = AudioViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(.heavyCurtainsVol1Cover)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer(minLength: 20)
                HStack {
                    Spacer(minLength: 24)
                    Image(.songsYouKnowButSlow)
                        .resizable()
                    Spacer(minLength: 24)
                }
                Spacer(minLength: 32)
                HStack {
                    Spacer()
                    Button(action: {
                        if !vm.isRecording {
                            vm.startRecording()
                        } else {
                            vm.stopRecording()
                            vm.fetchAllRecording()
                            self.addRecording.toggle()
                        }
                    }, label: {
                        if !vm.isRecording {
                            Image(systemName: "mic")
                                .resizable()
                                .frame(width: 40, height: 65)
                                .foregroundColor(.black)
                        } else {
                            Image("voiceMemo")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .foregroundColor(.black)
                        }
                    })
                    Spacer()
                }
                Spacer(minLength: 20)
                ZStack {
                    VStack {
                        NavigationView {
                            List {
                                ForEach(vm.recordingsList) { recording in
                                    HStack{
                                        Button {} label: {
                                            Label("", systemImage:"trash")
                                                .foregroundColor(.red)
                                                .onTapGesture {
                                                    vm.deleteRecording(url: recording.fileURL)
                                                }
                                        }
                                        Text("\(String(recording.name.dropLast(4)))")
                                        
                                        Spacer()
                                        
                                        Button {} label: {
                                            Label("", systemImage: recording.isPlaying ? "stop" : "play")
                                                .foregroundColor(.black)
                                                .onTapGesture {
                                                    if recording.isPlaying == true {
                                                        vm.stopPlaying(url: recording.fileURL)
                                                    } else {
                                                        vm.startPlaying(url: recording.fileURL)
                                                    }
                                                }
                                        }
                                    }
                                }.alignmentGuide(.listRowSeparatorLeading) { _ in
                                    0
                                }
                            }
                        }.sheet(isPresented: $addRecording) {
                            VStack {
                                Text("Song Name: ")
                                HStack {
                                    TextField("Add a Song", text: self.$addRecordingName)
                                        .multilineTextAlignment(.center)
                                }
                                Button(action: {
                                    vm.updateFileName(url: vm.recordingsList[0].fileURL, newName: self.addRecordingName)
                                    
                                    self.addRecording.toggle();

                                    self.addRecordingName = "";
                                }, label: {
                                    Text("Add")
                                })
                            }
                            .padding(10)
                            .gridCellAnchor(.center)
                        }

                    }
                }
            }
        }
        .background(Color(.white))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

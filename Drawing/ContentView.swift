//
//  ContentView.swift
//  Drawing
//
//  Created by P.M. Student on 5/10/21.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var canvas = PKCanvasView()
    @State var isDrawing = true
    @State var color : Color = .black
    @State var type : PKInkingTool.InkType = .pencil
    @State var colorPicker = false
    
    
    // default is pen...
    
    var body: some View {
        NavigationView {
            //Drawing view
            
            DrawingView(canvas: $canvas, isDraw: $isDrawing, type: $type, color: $color)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    
                    // saving image...
                    
                }, label: {
                    Image(systemName: "square.and.arrow.down.fill")
                        .font(.title)
                } ),trailing: HStack(spacing: 15) {
                    Button(action: {
                        
                        //erase tool...
                        
                        isDrawing =  false
                        
                    }) {
                        Image(systemName: "pencil.slash")
                            .font(.title)
                    }
                    
                    
                    Menu {
                        
                        Button(action: {
                            
                            colorPicker.toggle()
                            
                        }) {
                            Label {
                                Text("Color")
                            } icon: {
                                Image(systemName: "eyedropper.full")
                            }
                        }
                        Button(action: {
                            
                            isDrawing = true
                            type = .pencil
                            
                        }) {
                            Label {
                                Text("Pencil")
                            } icon: {
                                Image(systemName: "pencil.fill")
                            }
                        }
                        Button(action: {
                            
                            isDrawing = true
                            type = .pen
                            
                        }) {
                            Label {
                                Text("Pen")
                            } icon: {
                                Image(systemName: "pencil")
                            }
                        }
                        Button(action: {
                            
                            isDrawing = true
                            type = .marker
                            
                        }) {
                            Label {
                                Text("Marker")
                            } icon: {
                                Image(systemName: "highlighter")
                            }
                        }
                        

                        
                    } label: {
                        Image("menu")
                            .resizable()
                            .frame(width: 22, height: 22)
                    }
                    
                })
                .sheet(isPresented: $colorPicker) {
                    
                    ColorPicker("Pick color", selection: $color)
                        .padding()
                    
                    
                }
        }
    }
}

struct DrawingView: UIViewRepresentable {
    
    @Binding var canvas: PKCanvasView
    @Binding var isDraw : Bool
    @Binding var type: PKInkingTool.InkType
    @Binding var color : Color
    
    var ink : PKInkingTool{
        PKInkingTool(type, color: UIColor(color))
    }
    
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView{
        
        canvas.drawingPolicy = .anyInput
        
        canvas.tool = isDraw ? ink : eraser
        
        return canvas
        
    }
        func updateUIView(_ uiView: PKCanvasView, context: Context) {
            
            //updating tool whenever main view updates.
            
            uiView.tool = isDraw ? ink : eraser
            
    }
}

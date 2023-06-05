//
//  PostingScreenView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/25/23.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore


struct PostingScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var viewModel : PostingScreenViewModel
    
    init(){
        let container = DependencyContainer()
        viewModel = PostingScreenViewModel(firestoreService: container.firestoreService, storageService: container.storageService)
    }
    
    let star : AttributedString = {
        var result = AttributedString("*")
        result.font = UIFont(name: "Work Sans", size: 13)
        result.foregroundColor = .red
        return result
    }()
    
    //MARK: Options title
    
    @State var selectedCategory = "Căn hộ/ chung cư"
    let listCategory = ["Căn hộ/ chung cư","Nhà ở", "Đất", "Văn phòng, mặt bằng kinh doanh", "Phòng trọ"]
    
    @State private var selectedChip: String? = nil
    let chipOptions = ["Cần bán", "Cho thuê"]
    
    //MARK: Real estate address and photos
    
    @State var buildingName: String = ""
    @State var tintBuildingName : String = "Nhập tên toà nhà/ khu dân cư/ dự án"
    
    @State var address: String = ""
    @State var tintAddress : String = "Nhập địa chỉ"
    
    @State var isShowVideoPicker = false
    @State var isShowPhotoPicker = false
    
    @State var url : String?
    @State var images: [UIImage] = []
    
    //MARK: Real Estate Location
    
    @State var apartmentCode: String = ""
    @State var tintApartmentCode : String = "Nhập mã căn hộ"
    
    @State var block: String = ""
    @State var tintBlock : String = "Nhập Block/ tháp"
    
    @State var floor: String = ""
    @State var tintFloor : String = "Nhập tầng số"
    
    //MARK: Information Details
    
    @State var apartmentType: String = ""
    @State var tintApartmentType : String = "Chọn loại hình căn hộ"
    let listApartmentType : [String] = ["Chung cư", "Chung cư cao cấp"]
    
    @State var bedrooms: String = ""
    @State var tintBedrooms : String = "Nhập số phòng ngủ"
    
    @State var bathrooms: String = ""
    @State var tintBathrooms : String = "Nhập số phòng vệ sinh"
    
    @State var balconyDirection: String = ""
    @State var tintBalconyDirection : String = "Hướng ban công"
    
    @State var entranceDirection: String = "Đông"
    let listDirection = ["Đông", "Tây", "Nam", "Bắc", "Đông Bắc", "Đông Nam", "Tây Bắc", "Tây Nam"]
    
    //MARK: Other Infomation
    
    @State var legalDocuments: String = ""
    @State var tintLegalDocuments : String = "Chọn giấy tờ pháp lý"
    let listLegalDocuments = ["Đã có sổ", "Đang chờ sổ", "Giấy tờ khác"]
    
    @State var interiorStatus: String = ""
    @State var tintInteriorStatus : String = "Chọn tình trạng nội thất"
    let listInteriorStatus = ["Không nội thất", "Full nội thất"]
    
    //MARK: Area & Price
    
    @State var area: String = ""
    @State var tintArea: String = "Nhập diện tích căn hộ"
    
    @State var price: String = ""
    @State var tintPrice: String = "Nhập giá căn hộ"
    
    @State var depositAmount: String = ""
    @State var tintDepositAmount: String = "Nhập số tiền cọc"
    
    //MARK: Post title and detailed description
    
    @State var postTitle: String = ""
    @State var tintPostTitle: String = "Nhập tiêu đề tin đăng"
    
   
    @State private var textEditorValue: String = "Lorem ipsum..."
    @State var textEditorHeight : CGFloat = 20
    @State var postDecription: String = """
Nên có: loại căn hộ chung cư, vị trí, tiện ích, điện tích, số phòng, thông tin pháp lý, tình trạng nội thất,...

Ví dụ: Toạ lạc tại đường số 2 Đ.N4, căn hộ Duplex Cenladon City Q.Tân Phú 68m2 2PN, WC. Tiện ích đầy đủ
"""
    @State var isFirstClickOnDecription = true
    
    @State var isChangeScreen = false
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Đăng tin")
                            .font(.custom("Work Sans", size: 17))
                    }
                    .foregroundColor(Color(hex: "#072331"))
//                    .bold()
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .padding(.bottom, 16)
            
            NavigationLink(destination: GetAllPostView(), isActive: $isChangeScreen) {
                
            }
            
            ScrollView(.vertical){
                VStack(spacing: 16){
                    FakeDropDownView(selection: $selectedCategory, listOptions: listCategory, label: "Danh mục", isRequested: true)
                        .padding(.top, 10)
                    
                    HStack(spacing: 0){
                        Text("Danh mục bất động sản")
                            .font(.custom("Work Sans", size: 17))
                        Text("*")
                            .foregroundColor(Color(hex: "#DF4B4B"))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)
                    
                    HStack {
                        ForEach(chipOptions, id: \.self) { chip in
                            Text(chip)
                                .font(.custom("Work Sans", size: 13))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(selectedChip == chip ? Color(hex: "#5276F0") : Color(hex: "#5959590F"))
                                        .opacity(selectedChip == chip ? 1 : 0.6)
                                )
                                .foregroundColor(selectedChip == chip ? .white : .black)
                                .onTapGesture {
                                    selectedChip = chip
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background {
                    Color.white
                }
                .padding(.bottom, 10)
                
                //MARK: Real estate address and photos
                
                VStack (spacing: 16){
                    
                    Text("Địa chỉ BĐS và hình ảnh")
                        .font(.custom("Work Sans", size: 17))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    OutlineTextFieldView(label: "Tên toà nhà", input: $buildingName, tint: $tintBuildingName)
                    
                    VStack(spacing: 0){
                        OutlineTextFieldView(label: "Địa chỉ", input: $address, tint: $tintAddress, isRequired: true)
                        
                        if address == "" {
                            Text("Vui lòng nhập thông tin")
                                .font(.custom("Work Sans", size: 13))
                                .foregroundColor(.red)
                        }
                    }
                   
                    
                    if url == nil {
                        Button {
                            isShowVideoPicker.toggle()
                        } label: {
                            HStack{
                                Image(systemName: "video.and.waveform")
                                
                                Text("Đăng tối đa 1 video")
                                    .font(.custom("Work Sans", size: 17))
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background{
                                Rectangle()
                                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .cornerRadius(8)
                                    .foregroundColor(Color(hex: "#5276F0"))
                                
                            }
                        }
                    } else {
                        
                        HStack{
                            Button {
                                isShowVideoPicker = true
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "#EFEDED"))
                                    VStack{
                                        Image(systemName: "video.and.waveform")
                                            .foregroundColor(.black)
                                        
                                        Text("Thay video")
                                            .font(.custom("Work Sans", size: 17))
                                            .foregroundColor(.black)
                                            .opacity(0.5)
                                    }
                                }
                                .frame(maxWidth: 124.4, maxHeight: 70)
                            }
                            
                            VideoThumbnailView(url: URL(string: url!)!){
                                url = nil
                            }
                            .cornerRadius(10)
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 70, alignment: .leading)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .background{
                            Rectangle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .cornerRadius(8)
                                .foregroundColor(Color(hex: "#5276F0"))
                        }
                    }
                    
                    if images.count == 0 {
                        
                        Button {
                            isShowPhotoPicker.toggle()
                        } label: {
                            HStack{
                                Image(systemName: "photo.on.rectangle")
                                
                                Text("Đăng từ 3 đến 12 hình ( tỷ lệ 16:9)")
                                    .font(.custom("Work Sans", size: 17))
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background{
                                Rectangle()
                                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .cornerRadius(8)
                                    .foregroundColor(Color(hex: "#5276F0"))
                                
                            }
                        }
                        
                    } else {
                        ScrollView(.horizontal){
                            if images.count < 12 {
                                LazyHStack {
                                    Button {
                                        isShowPhotoPicker = true
                                    } label: {
                                        Image("chooseImage")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 124.4, maxHeight: 70)
                                    }
                                    
                                    ForEach(images.indices, id: \.self) { index in
                                        ShowImagesView(uiImage: images[index]) {
                                            images.remove(at: index)
                                        }
                                    }
                                }
                            } else {
                                LazyHStack {
                                    ForEach(images.indices, id: \.self) { index in
                                        ShowImagesView(uiImage: images[index]) {
                                            images.remove(at: index)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 12)
                        .padding(.leading, 20)
                       
                        .background{
                            Rectangle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .cornerRadius(8)
                                .foregroundColor(Color(hex: "#5276F0"))
                        }
                    }
                    
                    if images.count < 3 {
                        Text("Bạn cần nhập vào ít nhất 3 hình ảnh để có thể tiếp tục")
                            .font(.custom("Work Sans", size: 13))
                            .foregroundColor(.red)
                    }
                    
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .background(.white)
                .padding(.bottom, 10)
                
                //MARK: Real Estate Location
                
                VStack(spacing: 16){
                    Text("Vị trí Bất động sản")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Work Sans", size: 17))
//                        .bold()
                    
                    HStack(spacing: 14) {
                        OutlineTextFieldView(label: "Mã căn", input: $apartmentCode, tint: $tintApartmentCode)
                        
                        OutlineTextFieldView(label: "Block", input: $block, tint: $tintBlock)
                        
                    }
                    
                    HStack(spacing: 14) {
                        OutlineTextFieldView(label: "Tầng số", input: $floor, tint: $tintFloor)
                        
                        Rectangle().fill(.clear)
                        
                    }
                    
                    
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .background(.white)
                .padding(.bottom, 10)
                
                //MARK: Information Details
                
                VStack(spacing: 16){
                    Text("Thông tin chi tiết")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Work Sans", size: 17))
//                        .bold()
                    
                    VStack(spacing: 0) {
                        FakeDropDownView(selection: $apartmentType, tint: $tintApartmentType, listOptions: listApartmentType, label: "Loại hình căn hộ", isRequested: true)
                            .padding(.top, 10)
                        
                        if apartmentType == "" {
                            Text("Vui lòng chọn loại hình căn hộ")
                                .font(.custom("Work Sans", size: 13))
                                .foregroundColor(.red)
                        }
                    }
                    
                    
                    HStack(spacing: 14) {
                        
                        VStack(spacing: 0) {
                            OutlineTextFieldView(label: "Số phòng ngủ", input: $bedrooms, tint: $tintBedrooms, isRequired: true)
                            
                            if bedrooms == "" {
                                Text("Vui lòng nhập thông tin")
                                    .font(.custom("Work Sans", size: 13))
                                    .foregroundColor(.red)
                            }
                        }
                        
                        VStack(spacing: 0) {
                            OutlineTextFieldView(label: "Số phòng vệ sinh", input: $bathrooms, tint: $tintBathrooms, isRequired: true)
                            
                            if bathrooms == "" {
                                Text("Vui lòng nhập thông tin")
                                    .font(.custom("Work Sans", size: 13))
                                    .foregroundColor(.red)
                            }
                        }
                        
                    }
                    
                    HStack(spacing: 14) {
                        FakeDropDownView(selection: $balconyDirection, tint: $tintBalconyDirection, listOptions: listDirection, label: "Hướng ban công")
                        
                        FakeDropDownView(selection: $entranceDirection, listOptions: listDirection, label: "Hướng cửa chính")
                    }
                    
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .background(.white)
                .padding(.bottom, 10)
                
                //MARK: Other Infomation
                
                VStack(spacing: 16){
                    Text("Thông tin khác")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Work Sans", size: 17))
//                        .bold()
                    
                    FakeDropDownView(selection: $legalDocuments, tint: $tintLegalDocuments, listOptions: listLegalDocuments, label: "Giấy tờ pháp lý")
                    
                    FakeDropDownView(selection: $interiorStatus, tint: $tintInteriorStatus, listOptions: listInteriorStatus, label: "Tình trạng nội thất")
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .background(.white)
                .padding(.bottom, 10)
                
                //MARK: Area & Price
                
                VStack(spacing: 16){
                    Text("Diện tích & giá")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Work Sans", size: 17))
//                        .bold()
                    
                    VStack(spacing: 0) {
                        OutlineTextFieldView(label: "Diện tích", input: $area, tint: $tintArea, isRequired: true)
                        
                        if area == "" {
                            Text("Vui lòng nhập thông tin")
                                .font(.custom("Work Sans", size: 13))
                                .foregroundColor(.red)
                        }
                    }
                    
                    
                    VStack(spacing: 0) {
                        
                        OutlineTextFieldView(label: "Giá", input: $price, tint: $tintPrice, isRequired: true)
                        
                        if price == "" {
                            Text("Vui lòng nhập thông tin")
                                .font(.custom("Work Sans", size: 13))
                                .foregroundColor(.red)
                        }
                    }
                    
                    
                    OutlineTextFieldView(label: "Tiền cọc", input: $depositAmount, tint: $tintDepositAmount)
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .background(.white)
                .padding(.bottom, 10)
                
                //MARK: Post title and detailed description
                
                VStack(spacing: 16){
                    Text("Tiêu đề tin đăng và mô tả chi tiết")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Work Sans", size: 17))
//                        .bold()
                    
                    VStack(spacing: 0) {
                        
                        OutlineTextFieldView(label: "Tiêu đề", input: $postTitle, tint: $tintPostTitle, isRequired: true)
                        
                        if postTitle == "" {
                            Text("Vui lòng nhập thông tin")
                                .font(.custom("Work Sans", size: 13))
                                .foregroundColor(.red)
                        }
                    }
                    
                    VStack{
                        ZStack(alignment: .leading) {
                            Text(postDecription)
                                .font(.custom("Work Sans", size: 17))
                                .foregroundColor(.clear)
                                .padding(14)
                                .background(GeometryReader {
                                    Color.clear.preference(key: ViewHeightKey.self,
                                                           value: $0.frame(in: .local).size.height)
                                }
                                )
                            
                            TextEditor(text: $postDecription)
                                .font(.custom("Work Sans", size: 17))
                                .foregroundColor(isFirstClickOnDecription ? Color.black.opacity(0.5) : Color.black)
                                .frame(height: max(40,textEditorHeight))
                                .cornerRadius(10)
                                .shadow(radius: 1.0)
                                
                        }
                        .onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0}
                        
                    }
                    .onTapGesture(perform: {
                        if isFirstClickOnDecription {
                            isFirstClickOnDecription = false
                            postDecription = ""
                        }
                    })
                    .overlay(alignment: .topLeading) {
                        Text(AttributedString("Mô tả chi tiết") + star)
                            .font(.custom("Work Sans", size: 13))
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                            }
                            .offset(x : 20 ,y: -14)
                    }
                    
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .background(.white)
                .padding(.bottom, 10)
                
                HStack{
                    Button {
                        push()
                    } label: {
                        Text("Đăng tin")
                            .font(.custom("Work Sans", size: 17))
                            .bold()
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                            }
                    }
                    .disabled(!checkValid())
                }
                .padding(.horizontal, 20)
                
            }
        }
        .fullScreenCover(isPresented: $isShowVideoPicker, content: {
            ImagePicker(typePicker: .video){ urlVideo in
                url = urlVideo?.absoluteString
            }
        })
        .fullScreenCover(isPresented: $isShowPhotoPicker, content: {
            ImagePicker(typePicker: .image, getUIImage: { uiImage in
                images.append(uiImage)
            })
        })
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(hex: "EFEDED"))
        .navigationBarBackButtonHidden(true)
    }
    
    func push(){
        let buildModel = PostModelBuilder()
            .setBuildingName(buildingName)
            .setAddress(address)
            .setApartmentCode(apartmentCode)
            .setBlock(block)
            .setFloor(floor)
            .setApartmentType(apartmentType)
            .setBedrooms(bedrooms)
            .setBathrooms(bathrooms)
            .setBalconyDirection(balconyDirection)
            .setEntranceDirection(entranceDirection)
            .setLegalDocuments(legalDocuments)
            .setInteriorStatus(interiorStatus)
            .setArea(area)
            .setPrice(price)
            .setDepositAmount(depositAmount)
            .setPostTitle(postTitle)
            .setPostDecription(postDecription)
            .build()
        
        viewModel.createPost(withVideo: url ?? nil, andImages: images, post: buildModel){ result in
            switch result{
            case .success:
                isChangeScreen = true
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkValid() -> Bool {
        
        return  images.count >= 3 && selectedChip != nil && address != "" && apartmentType != "" && bedrooms != "" && bathrooms != "" && area != "" && price != "" && postTitle != "" && postDecription != "" && postDecription != """
Nên có: loại căn hộ chung cư, vị trí, tiện ích, điện tích, số phòng, thông tin pháp lý, tình trạng nội thất,...

Ví dụ: Toạ lạc tại đường số 2 Đ.N4, căn hộ Duplex Cenladon City Q.Tân Phú 68m2 2PN, WC. Tiện ích đầy đủ
"""
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct PostingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PostingScreenView( )
    }
}



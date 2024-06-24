import SwiftUI

struct AddAddressView: View {
    @State private var name: String = ""
    @State private var mobile: String = ""
    @State private var pinCode: String = ""
    @State private var address: String = ""
    @State private var locality: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var isHome: Bool = true
    @State private var isDefault: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Contact Details")) {
                    TextField("Name", text: $name)
                    TextField("Mobile No", text: $mobile)
                }
                
                Section(header: Text("Address")) {
                    TextField("Pin Code", text: $pinCode)
                    TextField("Address (House No, Building, Street, Area)", text: $address)
                    TextField("Locality/Town", text: $locality)
                    TextField("City/District", text: $city)
                    TextField("State", text: $state)
                }
                
                Section(header: Text("Save Address As")) {
                    HStack {
                        Button(action: {
                            isHome = true
                        }) {
                            Text("Home")
                                .foregroundColor(isHome ? .blue : .primary)
                        }
                        
                        Button(action: {
                            isHome = false
                        }) {
                            Text("Work")
                                .foregroundColor(!isHome ? .blue : .primary)
                        }
                    }
                }
                
                Section {
                    Toggle("Make this my default address", isOn: $isDefault)
                }
                
                Section {
                    Button(action: {
                        // Handle Add Address action
                    }) {
                        Text("Add Address")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationBarTitle("Add New Address")
        }
    }
}

struct AddAddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddAddressView()
    }
}

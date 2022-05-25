//
//  SettingsView.swift
//  TatarBook
//
//  Created by halsab on 18.05.2022.
//

import SwiftUI
import Contacts

struct SettingsView: View {
    var body: some View {
        Button {
            createAndSaveContact()
        } label: {
            Text("Add to contact")
                .capsuleButtonStyle()
                .padding()
        }
    }
    
    private func createAndSaveContact() {
        // Create a new contact
        let newContact = CNMutableContact()
        
        newContact.contactType = .person
        newContact.givenName = "Надежда"
        newContact.middleName = "Васильевна"
        newContact.familyName = "Куртяник"
        
        newContact.organizationName = "Министр государственного управления, информационных технологий и связи"
        newContact.departmentName = "МОСКОВСКАЯОБЛАСТЬ"
        newContact.jobTitle = "МИНГОСУПРАВЛЕНИЯ"
        
        newContact.imageData = UIImage(named: "profile")?.pngData()
        
        newContact.note = "Добавочный номер 40-227 для телефона +7 (498) 602-02-27"
        
        newContact.phoneNumbers = [
            CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: "+7 915 049 99 00")),
            CNLabeledValue(label: CNLabelPhoneNumberMain, value: CNPhoneNumber(stringValue: "+7 498 602 02 27"))
        ]
        newContact.emailAddresses = [
            CNLabeledValue(label: CNLabelWork, value: "KurtyanikNV@mosreg.ru")
        ]
        let address = CNMutablePostalAddress()
        address.street = "бульвар Строителей, дом 7, 11 этаж"
        address.city = "город Красногорск"
        address.state = "Московская область"
        address.postalCode = "143401"
        address.country = "Россия"
        newContact.postalAddresses = [
            CNLabeledValue(label: CNLabelWork, value: address)
        ]
        newContact.urlAddresses = [
            CNLabeledValue(label: CNLabelURLAddressHomePage, value: "mits.mosreg.ru")
        ]
        newContact.socialProfiles = [
            CNLabeledValue(
                label: "Telegram",
                value: CNSocialProfile(
                    urlString: "https://t.me/mingosmo",
                    username: "@mingosmo",
                    userIdentifier: nil,
                    service: "Telegram"
                )
            )
        ]
        
        // Save the contact
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(newContact, toContainerWithIdentifier: nil)
        
        do {
            try store.execute(saveRequest)
            print("Saving contact success")
        } catch {
            print("Saving contact failed, error: \(error)")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

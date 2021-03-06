import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtMultimedia 5.6


Rectangle
{
    signal backClicked
    signal createAccountClicked
    signal uploadImageClicked

    id: create_account_rect
    height: 400
    width: 400
    color: "cadetblue"
    visible: true

    Text{
        id: create_txt
        text: "Create Account"
        font.pointSize: 28
        font.bold: true
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle{ // new screen for upload image
        id: upload_img
        height:400
        width: 400
        visible: false
        z:1
        anchors.centerIn: parent

        Row{ // options row
            id: buttons_row
            height: camera_img.height
            width: parent.width
            visible: false
            anchors.bottom: parent.bottom

            Rectangle{ // cancel
                height: parent.height
                width: parent.width/2
                color: "white"
                border.width: 1
                Text{text: "Cancel"; font.pointSize: 10; anchors.centerIn: parent}

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        video.visible = true
                        close.visible = true
                        preview_img.visible = false
                        camera_img.visible = true
                        buttons_row.visible = false
                    }
                }
            }

            Rectangle{ // select
                height: parent.height
                width: parent.width/2
                color: "white"
                border.width: 1
                Text{text: "Select"; font.pointSize: 10; anchors.centerIn: parent}

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        // Set image
                        temp.source = preview_img.source
                        upload_img.visible = false
                        video.visible = true
                        close.visible = true
                        preview_img.visible = false
                        camera_img.visible = true
                        buttons_row.visible = false
                    }
                }
            }
        }


        Rectangle{ // russ fix it because I broke it JK I fixed it but I'm leaving comments in
            id: close
            height: 20
            width: 50
            border.width: 2
            anchors.right: parent.right
            Text{text: "Close"; font.pointSize: 10; anchors.centerIn: parent}

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    upload_img.visible = false              
                }
            }
        }

        Camera { // get persons image
            id: front_cam
            imageCapture{
                onImageCaptured: {
                    preview_img.source = preview
                    video.visible = false
                    preview_img.visible = true
                }
            }
        }

        VideoOutput{ // video stuff
            id: video
            anchors.fill: parent
            source: front_cam
            focus: visible

            Rectangle{
                height: upload_img.width / 2
                width: height
                color: "transparent"
                //border.width: 2 // outline for picture but its broken
                anchors.centerIn: parent
            }
        }

        Image{ // preview image
            id: preview_img
            anchors.fill: parent
            anchors.topMargin: camera_img.height
            anchors.bottomMargin: camera_img.height
            visible: false
        }

        Image{ // grab icon from img pack
            id: camera_img
            source: "../All images/camera.png"
            height: 50
            width: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            z:2

            MouseArea{ // clickable camera button
                id: camera_button
                anchors.fill: parent
                onClicked: {
                    front_cam.imageCapture.capture()
                    camera_img.visible = false
                    buttons_row.visible = true
                    close.visible = false
                    // image saved or image captured, because this is so broken
                    // WARNING: Your default photos folder will be broken with so many test pictures
                    // also you dont have a webcam so it wont matter for testing. use your laptop
                    //front_cam.imageCapture.captureToLocation("C:/Users/elusi/Documents/cst_238_GUI/RussT/src/Upload")
                }
            }
        }
    }

    // Back button that takes user to login screen
    Rectangle {
        id: back_button
        height: 20
        width: 40
        color: "silver"

        Text{
            text: "Back"
            color: "black"
            font.pointSize: 10
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                backClicked()
            }
        }
    }

    // circle for upload image
    Rectangle{
        height: parent.width / 4
        width: height
        color: "white"
        Text{text: "Upload an image"; anchors.centerIn: parent}
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height / -3.5
        border.color: "black"
        border.width: 2

        Image{
            id: temp
            anchors.fill: parent
            //fillMode: Image.PreserveAspectFit
            fillMode: Image.PreserveAspectCrop
        }
    }

    // buttons for create username, email, password
    Rectangle{
        id: create_username
        height: 30
        width: parent.width * .9
        color: "white"
        x: parent.width * .05
        y: parent.height * .5

        TextField{
            id: username_txt
            placeholderText: "Create username"
            anchors.fill: parent
        }

        Rectangle{
            id: create_email
            height: parent.height
            width: parent.width
            color: parent.color
            y: parent.height * 1.5

            TextField{
                id: email_txt
                placeholderText: "Enter email"
                anchors.fill: parent
            }

            Rectangle{
                id: create_password
                height: parent.height
                width: parent.width
                color: parent.color
                y: parent.height * 1.5

                TextField{
                    id: password_txt
                    placeholderText: "Create Password"
                    anchors.fill: parent
                }
            }
        }
    }

    // confirm create account button
    Rectangle{
        color: "silver"
        height: parent.height / (32/3)
        width: parent.width * .4375
        anchors.left: parent.left
        anchors.leftMargin: parent.width * .05
        y: create_username.y + (create_username.height * 4.5)

        Text{
            anchors.centerIn: parent
            text: "Upload Image"
            font.pointSize: parent.height / (60/14)
            color: "black"
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                /*open front facing camera*/
                uploadImageClicked();
                upload_img.visible = true
                //create_account_rect.visible = false
            }
        }
    }
    Rectangle{
        color: "silver"
        height: parent.height / (32/3)
        width: parent.width * .4375
        anchors.right: parent.right
        anchors.rightMargin: parent.width * .05
        y: create_username.y + (create_username.height * 4.5)

        Text{
            anchors.centerIn: parent
            text: "Create Account"
            font.pointSize: parent.height / (60/14)
            color: "black"
        }

        MouseArea{
            anchors.fill: parent
            onClicked: createAccountClicked()
        }
    }
}

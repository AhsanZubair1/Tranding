import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trade_watch/Extras/Constants.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:trade_watch/Extras/functions.dart';
import 'package:trade_watch/Model/Profile.dart';
import 'package:trade_watch/Screens/Dashboard/Settings.dart';
import 'package:trade_watch/Widgets/MainButton.dart';
import 'package:http/http.dart'as https;
class BottomSheat extends StatefulWidget {
 final Res? model;
 final String? header;
 BottomSheat({ this.model,required this.header});


  @override
  _BottomSheatState createState() => _BottomSheatState();
}

class _BottomSheatState extends State<BottomSheat> {
  late String code = "+1", country = "IN";


  var ec = TextEditingController();

  var nc = TextEditingController();


  var phc = TextEditingController();

  var rc = TextEditingController();
  List<String> phone = [];
  bool hit=false;

  late double height ,width;
  bool validate(){
    if(nc.text.trim().isEmpty){
      Fluttertoast.showToast(msg: 'Fields can\'t be empty');
      return false;
    }else
    if(!EmailValidator.validate(ec.text.trim())){
      Fluttertoast.showToast(msg: 'Invalid Email');
      return false;


    }else if(phc.text.trim().isEmpty){
      Fluttertoast.showToast(msg: 'Fields can\'t be empty');
      return false;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    nc.text=widget.model!.name ?? "";
    ec.text=widget.model!.email ?? "";
    if((widget.model!.phoneNo ?? "").contains(" ")){
      phone = widget.model!.phoneNo!.split(" ");
      phc.text = phone[1];
    }

    super.initState();
  }
  File _image=File("");
  bool pic=false;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          print(_image);

          _image==""?pic=false:pic=true;

        });

      } else {
        print('No image selected.');
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    String country='';
    return Container(
      //height: MediaQuery.of(context).size.height*0.60,
      width: MediaQuery.of(context).size.width,
      padding:EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Update",style: TextStyle(fontFamily: "pb",fontSize: 30),),
              ],
            ),
            SizedBox(height:height*0.01),
            pic==true?GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                height:height*0.3,
                width: width*0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image:FileImage(_image),
                    fit: BoxFit.cover

                        
                  )
                ),
              )
            ):GestureDetector(
              onTap: (){
                getImage();

              },
              child: Container(
                height:height*0.3,
                width: width*0.3,
                decoration: BoxDecoration(

                    image: DecorationImage(
                        image:AssetImage("assets/images/addimage.png"),




                    )
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: CColors.gray , width: 1),
                  borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: TextField(
                controller: nc,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    fontFamily: 'pr',
                    fontSize: 15,
                    color: CColors.textblack
                ),
                textInputAction: TextInputAction.next,
                onEditingComplete: (){
                  node.nextFocus();
                },

                decoration: InputDecoration(
                    border: InputBorder.none,

                    hintText: nc.text.toString()==""?'name':widget.model?.name.toString(),
                    hintStyle: TextStyle(
                        fontFamily: 'pr',
                        color: CColors.gray
                    )
                ),
              ),
            ),
            SizedBox(height: height * 0.01,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: CColors.gray , width: 1),
                  borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: TextField(
                controller: ec,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    fontFamily: 'pr',
                    fontSize: 15,
                    color: CColors.textblack
                ),
                textInputAction: TextInputAction.next,
                onEditingComplete: (){
                  node.nextFocus();
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'youremail@email.com',
                    hintStyle: TextStyle(
                        fontFamily: 'pr',
                        color: CColors.gray
                    )
                ),
              ),
            ),





            SizedBox(height: height * 0.03,),

            Text('Enter your mobile number, we\'ll send you an OTP to verify',
              style: TextStyle(
                  color: CColors.textblack,
                  fontSize: 14,
                  fontFamily: 'pr'
              ),
            ),

            SizedBox(height: height * 0.03,),

            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: CColors.gray , width: 1),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: CountryCodePicker(
                    initialSelection: phone.length == 2 ? phone[0] : country,
                    onChanged: (val){
                      code = val.dialCode??'0';
                      country = val.name??'pk';

                      print(code);
                      print(country);
                    },
                    showFlagMain: false,
                  ),
                ),


                SizedBox(width: width * 0.03,),
                Expanded(
                  child: Container(

                    decoration: BoxDecoration(
                        border: Border.all(color: CColors.gray , width: 1),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: TextField(
                      controller: phc,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: (){
                        node.unfocus();
                      },
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          fontFamily: 'pr',
                          fontSize: 15,
                          color: CColors.textblack
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:widget.model?.phoneNo==null?'Phone':widget.model?.phoneNo.toString(),
                          hintStyle: TextStyle(
                              fontFamily: 'pr',
                              color: CColors.gray
                          )
                      ),
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: height*0.03,),
            CButton((){
              if(validate()){
                var d = {
                  'Name' : nc.text.trim(),
                  'Email': ec.text.trim(),
                  'PhoneNo': '$code ${phc.text.trim()}',
                  'country':country,
                };
               submit();
               hit=true;
               if(hit==true){
                 Functions().showLoaderDialog(context);
               }

              }

            }, 'Update'),


          ],
        ),
      ),


    );
  }
  Future<void> submit()async{

    String tokenn=widget.header.toString();
        //"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIxMDMwIiwidW5pcXVlX25hbWUiOiJBaHNhbiBadWJhaXIiLCJJRCI6IjEwMzAiLCJuYmYiOjE2MjczNzk0OTUsImV4cCI6MTYyNzgxMTQ5NSwiaWF0IjoxNjI3Mzc5NDk1fQ.ebFzQs9EdoVJV3WdkdbC00GQg4kBghZOeyAOLUyw8SrQjZSu7pD1evy-k2VOKCMcoU5B6klZnY5HdP1fPaRPsw";
    final url=Constants.baseurl + 'api/Profile/SaveProfile';
    final response=await https.post(Uri.parse(url),
    headers: {"Content-Type": "application/json",
      "Authorization": "Bearer $tokenn"
      },
      body: jsonEncode(<String, String>{
        "Name" : nc.text.toString(),
        "Email": ec.text.toString(),
        "Phone":'$code ${phc.text.trim()}',
        "Password":"",
        "UniqueId":"",
        "Country":""
      })

    );
    Navigator.pop(context);
    if(response.statusCode==200){
      updateimage();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));

      print("yes");

    }
    else{
      print(response.body);
    }
    print(response.body);



  }

  patchimage()async{
    final url=Constants.baseurl + 'api/Profile/UploadImage';
    var request=https.MultipartRequest("POST",Uri.parse(url));
    Uint8List data=await _image.readAsBytes();
    List<int> list=data.cast();
    request.files.add(await https.MultipartFile.fromBytes("Image", list,filename: "Image.png"));
    request.headers.addAll(
      {
        "Content-type":"multipart/form-data",
        "Authorization":"Bearer ${widget.header}"
      }
    );
   final respose=await request.send();
   print({widget.header});
   print((respose.stream.bytesToString().asStream().listen((event) {
     var pars=json.decode(event);
     print(pars);
     print(respose.statusCode);
   })));


  }
  Future updateimage() async {
  //  LoadingDialog().showLoaderDialog(context , text: "Updating Image");


    Dio dio = new Dio();
    dio.options.headers = {
      'Authorization': "Bearer " + widget.header.toString(),
    };

    var formdata = FormData.fromMap({
      "Image": await MultipartFile.fromFile(_image.path,filename: '${DateTime.now().millisecondsSinceEpoch} .jpg'),
    });
    await dio.post(
      // "https://httpbin.org/post"
        Constants.baseurl + 'api/Profile/UploadImage'
        , data: formdata).then((value){
      if(value.statusCode == 200){
        Navigator.of(context).pop();

      }
      // print(value),
    });
  }


}

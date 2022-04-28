const functions = require('firebase-functions');
const admin = require('firebase-admin');
//const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');
// const functionsHttp = require('@google-cloud/functions-framework');
// const escapeHtml = require('escape-html');

admin.initializeApp();


  // HTTP Cloud Function.
// functionsHttp.http('helloHttp', (req, res) => {
//   res.send(`Hello ${escapeHtml(req.query.name || req.body.name || 'World')}!`);
// });


exports.promote = functions.https
.onRequest(async (req, res) => {
    // this funtion url - https://us-central1-<project-id>.cloudfunctions.net/date
    //https://us-central1-viewyourstories-4bf4d.cloudfunctions.net/date


     const dataQuery = req.query;

     const adUrl = dataQuery.adUrl;

     const adId = dataQuery.adId;

     const promoterId = dataQuery.promoterId;

    //  const querydata = dataQuery.data;

    //  const data =  JSON.parse(querydata);


    //  const adUrl = data.adUrl;
    //  const adId = data.adId;
    //  const promoterId = data.promoterId;

    //  const adDoc = await admin.firestore().collection('promotedAds').doc(promoterId).collection('ads').doc(adId).get();
    const adDoc =  admin.firestore().collection('promotedAds').doc(promoterId).collection('ads').doc(adId);

    await adDoc.update({'clickCount': admin.firestore.FieldValue.increment(1)}) 

    res.redirect(adUrl);


     

    //  const id = data;

    

    //  const body = req.body;
     
    //  const queryData = req.query ['data'];



    
     // Important: Make sure that all HTTP functions terminate properly.
     // By terminating functions correctly, you can avoid excessive charges from functions that run for too long. Terminate HTTP functions with res.redirect(), res.send(), or res.end().
     // resourse - https://firebase.google.com/docs/functions/http-events
     //res.redirect('https://flutter.dev/');
    // res.send(data);

    //res.send(data + queryData + body);
    // res.redirect(adUrl);
    //res.send(adUrl);

    });


   // function call url
   // https://us-central1-prmt-business.cloudfunctions.net/promote


   // add url = function url ? params{promoterId, adId, adUrl}

   //https://us-central1-prmt-business.cloudfunctions.net/promote?data={promoterId: N5Bjwqc0AGcKg4UXAJORJ90OiXw2, adId: 7REUdqeh77VkiDNSUjGa, adUrl: https://www.flipkart.com/noise-air-buds-pro-active-cancellation-quad-mic-transparency-mode-hyper-sync-technology-bluetooth-headset/p/itmbb872cf5dee66?pid=ACCG8NCYJAJ25XSK&lid=LSTACCG8NCYJAJ25XSKYQRDLV&marketplace=FLIPKART&q=noise+bluetooth+headphones&store=0pm%2Ffcn&srno=s_1_13&otracker=AS_QueryStore_OrganicAutoSuggest_3_14_na_na_na&otracker1=AS_QueryStore_OrganicAutoSuggest_3_14_na_na_na&fm=search-autosuggest&iid=93be6377-fd45-45ec-abed-816cf05a5360.ACCG8NCYJAJ25XSK.SEARCH&ppt=sp&ppn=sp&ssid=tm4dfl87340000001649268971173&qH=2f61de050e9f36d8}

    // {"adUrl": "https://flutter.dev/", "adId": "111", "promoterId": "222"}
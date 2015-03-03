---
layout: post
title: "Google Contacts - Installed App workflow HOWTO"
date: 2014-07-07 11:09:20 +1000
comments: true
categories: [Google, Authentication, Contacts API, HOWTO, Installed] 
---
Installed apps typically mean apps that are not web apps. 
Using the installed app authentication flow is sometimes better than using a Service Account.

### Pro
* don't need your admin to assign special "impersonate" permissions to the service account (once assigned it can impersonate anyone in the domain)
* don't need a Google Domain (see link ???)
* app can use the refresh token to continue to fetch from Google API's until the user is revoked.

### Con
* A user needs to accept the Scope of the app, not too bad as once accepted it can continue to use the refresh token to keep accessing the API
* con you can't choose the OAuth2 redurect_URI just get magig top of page or http://localhost (any port you want) so no good for webapps... but then they have a Web-AppClient if you want that.


## Create a project in [Google Dev Console](https://console.developers.google.com)
The Google page explaining how to use it is [here](https://developers.google.com/accounts/docs/OAuth2InstalledApp) but here is a concreate example.

1. Click "Create a client ID" -> "Installed application"
  - This give you a client with these details:- 

    Client ID for native application
    
    CLIENT ID 758647508586-0vnrjg9dv7gr9h1qvqle58rd4kq0lu45.apps.googleusercontent.com 
    CLIENT SECRET  _Br_xUcZSfgmsuPrRmxkavV9 
    
    REDIRECT URIS  
      urn:ietf:wg:oauth:2.0:oob
      http://localhost

2. Request the authentication code [I'm requesting auth for the contacts API see the scope (here](https://developers.google.com/google-apps/contacts/v3/#authorizing_requests_with_oauth_20)
  - The request is made up of :- 
  - The Google oath code request URI = https://accounts.google.com/o/oauth2/auth
  - The Google ContactAPI read/write scope = https://www.google.com/m8/feeds
  - The redirect uri to put the code in the page title and code div = urn:ietf:wg:oauth:2.0:oob  [see googledocs](https://developers.google.com/accounts/docs/OAuth2InstalledApp#choosingredirecturi)
  - response_type = code
  - client_id = the Client_ID found in the dev console, see above

    https://accounts.google.com/o/oauth2/auth?scope=https%3A%2F%2Fwww.google.com%2Fm8%2Ffeeds&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&client_id=758647508586-0vnrjg9dv7gr9h1qvqle58rd4kq0lu45.apps.googleusercontent.com

3. look at the response there will be a code in the page title and also in a div with id='code' in the page like below

    4/7x7B5YMMVMQ1S7iWQ1PnOcFRGqyj.cuXlXIEu_icYdJfo-QBMszswfSocjgI

4. now we have the authorisation code we need to exchange it for an access token, this is done with a POST [see here](https://developers.google.com/accounts/docs/OAuth2InstalledApp#handlingtheresponse) 

    POST https://accounts.google.com/o/oauth2/token
    
    code=4/7x7B5YMMVMQ1S7iWQ1PnOcFRGqyj.cuXlXIEu_icYdJfo-QBMszswfSocjgI&client_id=758647508586-0vnrjg9dv7gr9h1qvqle58rd4kq0lu45.apps.googleusercontent.com&client_secret=_Br_xUcZSfgmsuPrRmxkavV9&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code
    
5. parse the result (see below) we'll need to store the access_token and the refresh_token.

    {
        "access_token" : "ya29.OwAPW_yxF27ZMB4AAACPwV13K2FYvOqzrCppl-9wp4poGBiYfvl6ibeqHPwYgg",
        "token_type" : "Bearer",
        "expires_in" : 3600,
        "refresh_token" : "1/m8wiWvc63swre62YXwrECE-SEqlQBf1Vb62Zb28-3lE"
    }

6. Use the access token to finally make a Google API call
  - here I'm calling the Contacts API asking for all contacts (for the user who authenticated in step 1)
  - you can add the token in a header or as a parameter (header is better as it won't be stored in the URL)

    https://www.google.com/m8/feeds/contacts/default/full
    
    Authorization: Bearer ya29.OwAPW_yxF27ZMB4AAACPwV13K2FYvOqzrCppl-9wp4poGBiYfvl6ibeqHPwYgg

    eg

    curl https://www.google.com/m8/feeds/contacts/default/full?access_token=ya29.OwAPW_yxF27ZMB4AAACPwV13K2FYvOqzrCppl-9wp4poGBiYfvl6ibeqHPwYgg

    or
    curl -H "Authorization: Bearer ya29.OwAPW_yxF27ZMB4AAACPwV13K2FYvOqzrCppl-9wp4poGBiYfvl6ibeqHPwYgg" https://www.google.com/m8/feeds/contacts/default/full

7. Read the results :-) Enjoy.


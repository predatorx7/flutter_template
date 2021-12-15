`keytool -genkey -v -keystore example.keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias cat -storepass example@123 -keypass example@123`

What is your first and last name?
  [Unknown]:  Mushaheed Syed
What is the name of your organizational unit?
  [Unknown]:  IT
What is the name of your organization?
  [Unknown]:  Binary Numbers Itzone LLP
What is the name of your City or Locality?
  [Unknown]:  Mumbai
What is the name of your State or Province?
  [Unknown]:  Maharashtra
What is the two-letter country code for this unit?
  [Unknown]:  IN
Is CN=Mushaheed Syed, OU=IT, O=Binary Numbers Itzone LLP, L=Mumbai, ST=Maharashtra, C=IN correct?
  [no]:  yes

Generating 2,048 bit RSA key pair and self-signed certificate (SHA256withRSA) with a validity of 10,000 days
        for: CN=Mushaheed Syed, OU=IT, O=Binary Numbers Itzone LLP, L=Mumbai, ST=Maharashtra, C=IN
[Storing example.keystore.jks]

`keytool -importkeystore -srckeystore example.keystore.jks -destkeystore example.keystore.p12 -deststoretype pkcs12`
`openssl pkcs12 -in .\example.keystore.p12`

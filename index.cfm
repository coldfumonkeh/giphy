<!--- Instantiate the object --->
<cfset objGiphy = createObject("component", "com.coldfumonkeh.giphy.giphy").init() />

<!--- Request from the API --->
<cfset stuTranslate = deserializeJSON(objGiphy.translate('code')) />
<cfdump var="#stuTranslate#" />   

<cfset stuGIFDetails = deserializeJSON(objGiphy.getGIF('hAPn6D5858HmM')) />
<cfdump var="#stuGIFDetails#" />
<cfcomponent extends="mxunit.framework.TestCase">
	
	<cffunction name="setUp">
		
	</cffunction>

	<cffunction name="beforeTests" returntype="void" access="public" hint="put things here that you want to run before all tests">
    	<cfset objGiphy 	= createObject("component", "scratch.com.coldfumonkeh.giphy.giphy").init() />
    </cffunction>

	<cffunction name="tearDown">
		
	</cffunction>

	<cffunction name="checkObjectIsObject">
		<cfset assertTrue(isObject(objGiphy), "objGiphy should be an object.") />
	</cffunction>

	<cffunction name="deserializedResponseIsJSON">
		<cfset var strResponse = objGiphy.translate('superman') />
		<cfset assertTrue(isStruct(deserializeJSON(strResponse)), "Response should be a struct.") />
	</cffunction>

	<cffunction name="responseIsOK">
		<cfset var stuResponse = deserializeJSON(objGiphy.translate('superman')) />
		<cfset assertEquals(stuResponse.META['status'], "200") />
	</cffunction>

	<cffunction name="responseIsBad">
		<cfset var objGiphy2 	= createObject("component", "scratch.com.coldfumonkeh.giphy.giphy").init(api_key='1234567890') />
		<cfset var stuResponse 	= deserializeJSON(objGiphy2.translate('superman')) />
		<cfset debug(stuResponse) />
		<cfset assertEquals(stuResponse.META['code'], "403") />
	</cffunction>

	<cffunction name="apiURLIsAMatch">
		<cfset var strResponse = objGiphy.getBaseURI() />
		<cfset assertEquals(strResponse, "http://api.giphy.com/v1/gifs") />
	</cffunction>

	<cffunction name="apiKeyIsAMatch">
		<cfset var strResponse = objGiphy.getAPIKey() />
		<cfset assertEquals(strResponse, "dc6zaTOxFJmzC") />
	</cffunction>

</cfcomponent>
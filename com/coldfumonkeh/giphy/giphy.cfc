<cfcomponent output="false">
    
    <cfproperty name="api_key"  type="string" />
    <cfproperty name="base_uri" type="string" />
    
    <cffunction name="init" output="false" hint="The constructor method.">
        <cfargument name="api_key"  type="string" required="true" default="dc6zaTOxFJmzC"                   hint="The API key required to access the service." />
        <cfargument name="base_uri" type="string" required="true" default="http://api.giphy.com/v1/gifs"   hint="The base URI endpoint for the API call." />
            <cfset setAPIKey(arguments.api_key) />
            <cfset setBaseURI(arguments.base_uri) />
        <cfreturn this />
    </cffunction>
                    
    <!--- SETTERS AND GETTERS --->
    <cffunction name="setAPIKey" access="private" output="false" hint="I set the API key property value.">
        <cfargument name="api_key" type="string" required="true" hint="The API key required to access the service." />
            <cfset variables.api_key = arguments.api_key />
    </cffunction>
                
    <cffunction name="getAPIKey" access="public" output="false" hint="I get the API key property value.">
        <cfreturn variables.api_key />
    </cffunction>
    
    <cffunction name="setBaseURI" access="private" output="false" hint="I set the base URI property value.">
        <cfargument name="base_uri" type="string" required="true" hint="The base URI endpoint for the API call." />
            <cfset variables.base_uri = arguments.base_uri />
    </cffunction>
                
    <cffunction name="getBaseURI" access="public" output="false" hint="I get the base URI property value.">
        <cfreturn variables.base_uri />
    </cffunction>
    
    <!--- UTILS --->
    <cffunction name="makeRequest" access="private" output="false" hint="I make the request to the API using the provided method name and request type.">
        <cfargument name="api_method"       required="true"   type="string"                             hint="The method or endpoint to call on the API." />
        <cfargument name="parameters"       required="false"  type="struct" default="#structNew()#"     hint="A structure of values to send through to the request as URL parameters." />
        <cfargument name="request_method"   required="false"  type="string" default="GET"               hint="The method to use for the API request. Defaults to GET." />
            <cfset var strURL = getBaseURI() />
                <cfif len(arguments.api_method)>
                    <cfset strURL = strURL & '/' & arguments.api_method />
                </cfif>
                <cfset strURL = strURL & '?api_key=' & getAPIKey() & '&' & buildParamString(arguments.parameters) />
                <cfhttp url="#strURL#" method="#arguments.request_method#" result="stuResponse" />
        <cfreturn stuResponse.fileContent />
    </cffunction>
    
    <cffunction name="buildParamString" access="private" output="false" returntype="string" hint="I loop through a struct to convert to query params for the URL">
        <cfargument name="argScope" required="true" type="struct" hint="I am the struct containing the method params" />
            <cfset var strURLParam         = '' />
            <cfloop collection="#arguments.argScope#" item="local.key">
                <cfif len(arguments.argScope[key])>
                    <cfif listLen(strURLParam)>
                        <cfset strURLParam = strURLParam & '&' />
                    </cfif>
                <cfset strURLParam = strURLParam & lcase(key) & '=' & arguments.argScope[key] />
                </cfif>
            </cfloop>
        <cfreturn strURLParam />
    </cffunction>
    
    <!--- API METHODS --->
    
    <cffunction name="recent" access="public" output="false" hint="I fetch most recent GIFs, optionally limited by tag. Returns 10 results. Additional GIF size data can be looked up by using the get GIF by id.">
        <cfargument name="tag"      required="false" type="string"  hint="An optional tag parameter limits recent GIFs to a specific tag." />  
        <cfargument name="limit"    required="false" type="numeric" hint="An optional value that sets the limits of the results returned. Max is 100." />
        <cfreturn makeRequest(api_method='recent', parameters=arguments) />
    </cffunction>
    
    <cffunction name="translate" access="public" output="false" hint="This is a prototype endpoint for using Giphy as a translation engine for a GIF dialect. The translate API draws on search, but uses the Giphy 'special sauce' to handle translating from one vocabulary to another. In this case, words to GIFs.">
        <cfargument name="s" required="true" type="string" hint="The term or phrase to translate into a GIF." />
            <cfreturn makeRequest(api_method='translate', parameters=arguments) />
    </cffunction>
    
    <cffunction name="search" access="public" output="false" hint="I perform a search against the API for the provided query.">
        <cfargument name="q" required="true" type="string" hint="The query keyword for which to search." />
            <cfreturn makeRequest(api_method='search', parameters=arguments) />
    </cffunction>
    
    <!--- TODO: Flagged Endpoint (read) --->
    
    <!--- TODO: Flagged Endpoint (write) --->
    
    <cffunction name="getfavorites" access="public" output="false" hint="I perform a search against the API for the provided query.">
        <cfreturn makeRequest(api_method='favorites') />
    </cffunction>
    
    <!--- TODO: Favorites Endpoint (write) --->
    
    
    
    
    <cffunction name="screensaver" access="public" output="false" hint="I perform a search against the API for the provided query.">
        <cfargument name="tag" required="false" type="string" hint="A specific tag to include in the screensaver search. If excluded, a random GIF will be returned." />   
            <cfreturn makeRequest(api_method='screensaver', parameters=arguments) />
    </cffunction>
    
    <cffunction name="artists" access="public" output="false" hint="I perform a search against the API for the provided query.">
        <cfargument name="username" required="false" type="string"  hint="An optional username parameter limits the response to GIFs created by artist username." /> 
        <cfargument name="limit"    required="false" type="numeric" hint="An optional value that sets the limits of the results returned. Max is 100." />  
        <cfargument name="offset"   required="false" type="numeric" hint="An optional value to set the start position in results. Defaults to 0." />  
            <cfreturn makeRequest(api_method='artists', parameters=arguments) />
    </cffunction>
    
    <cffunction name="getGIF" access="public" output="false" hint="I perform a search against the API for the provided query.">
        <cfargument name="gif_id" required="false" type="string" hint="The ID of a specific GIF to return." />    
            <cfreturn makeRequest(api_method=arguments.gif_id, parameters=arguments) />
    </cffunction>
    
    <cffunction name="getGIFs" access="public" output="false" hint="I perform a search against the API for the provided GIFs. I can take a comma delimited list of GIF id values.">
        <cfargument name="ids" required="false" type="string" hint="The ID of a specific GIF to return." />    
            <cfreturn makeRequest(api_method='', parameters=arguments) />
    </cffunction>
    
    <cffunction name="trending" access="public" output="false" hint="I perform a search against the API for the GIFs that are currently trending online.">
        <cfargument name="limit"    required="false" type="numeric" hint="An optional value that sets the limits of the results returned. Max is 100." />  
            <cfreturn makeRequest(api_method='trending', parameters=arguments) />
    </cffunction>
    
    <cffunction name="reactions" access="public" output="false" hint="I return a list of Reaction categories. For each reaction returned in the list, an appropriate emoji icon is provided in small, medium and large sizes, in addition to an example GIF classified under that reaction.">
       <cfreturn makeRequest(api_method='reactions') />
    </cffunction>
    
    <!--- TODO: GIFs by Reaction Endpoint --->
    
    <cffunction name="categories" access="public" output="false" hint="I return a complete list of GIF categories, compiled by the Giphy editorial team.">
       <cfreturn makeRequest(api_method='categories') />
    </cffunction>
    
    <cffunction name="tagsbycategory" access="public" output="false" hint="I return a complete list of GIF categories, compiled by the Giphy editorial team.">
        <cfargument name="category_name" required="false" type="string" hint="The name of the category within which to search for tags." />
        <cfreturn makeRequest(api_method='categories/#arguments.category_name#') />
    </cffunction>
    
    
    <!--- TODO: GIFs by Category Tag Endpoint --->
    

</cfcomponent>
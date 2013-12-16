# Giphy API ColdFusion Wrapper
---

Want to query and access a library full of animated GIFs? Of course you do!
Running ColdFusion as your server-side language? Of course you are!

This library is for you!

## Authors

Developed by Matt Gifford (@coldfumonkeh)

- http://www.mattgifford.co.uk
- http://www.monkehworks.com


### Share the love

Got a lot out of this package? Saved you time and money?

Share the love and visit Matt's wishlist: http://www.amazon.co.uk/wishlist/B9PFNDZNH4PY 

---

## Requirements

This package requires ColdFusion 8+

## Instantiation

Instantiation simply involves creating the object into whichever scope you wish to place it like so:

<cfset objGiphy = createObject("component", "com.coldfumonkeh.giphy.giphy").init() />

There are two optional parameters for the __init()__ method:

- __api_key__ - the API key to use with each request
- __base_uri__ - the base URI to form the request URL

These are both set with default values within the __init()__ method, but can be updated if the API schema changes at any time.


## API Access

At present the API is open to all. It does require an API key, but this is currently a shared 'beta' key: __dc6zaTOxFJmzC__

This key is set as the default value for the __api_key__ property within the CFC. This can be overwritten using the __init()__ method during instantiation if required as / when the API requirements change.
As it stands, for the moment you need not adjust this value to retrieve results from the request.

## Public Methods

The methods available to use within this wrapper and in conjunction with the API are as follows:

- __recent__

	This method fetches the most recent GIFs, optionally limited by tag. Returns 10 results. Additional GIF size data can be looked up by using the get GIF by id.

- __translate__

	This is a prototype endpoint for using Giphy as a translation engine for a GIF dialect. The translate API draws on search, but uses the Giphy 'special sauce' to handle translating from one vocabulary to another. In this case, words to GIFs.

- __search__

	This method performs a search against the API for the provided query.

- __getfavorites__
	
- __screensaver__
	
- __artists__

- __getGIF__

- __getGIFs__

	This method performs a search against the API for the provided GIFs. I can take a comma delimited list of GIF id values.

- __trending__

	This method performs a search against the API for the GIFs that are currently trending online.

- __reactions__

	This method returns a list of Reaction categories. For each reaction returned in the list, an appropriate emoji icon is provided in small, medium and large sizes, in addition to an example GIF classified under that reaction.

- __categories__

	This method returns a complete list of GIF categories, compiled by the Giphy editorial team.
	
- __tagsbycategory__


## Useful Links


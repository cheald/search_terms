search_terms is a simple plugin that augments request to let you extract what a user was searching for that landed them on your page by analyzing the request referer against a list of known hosts.

For example, if you have the following referrer:

   http://www.google.com/search?q=digsby+reviews&client=firefox-a
   
You may call:
 
   request.search_terms => "digsby reviews"
   
To find out if a request came from a search engine, just call:

  request.referred_by_search_engine?

And that's about all there is to it.
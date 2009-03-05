# inspired by http://www.insiderpages.com/rubyonrails/2007/01/get-referring-search-engine-keywords.html

module ActionController
	class AbstractRequest
		cattr_accessor :search_engines
		@@search_engines = [
			[/^(www\.)?google.*/, 		'q'],
			[/^search\.yahoo.*/, 		'p'],
			[/^search\.msn.*/, 			'q'],
			[/^search\.aol.*/, 			'userQuery'],
			[/^(www\.)?altavista.*/, 	'q'],
			[/^(www\.)?feedster.*/, 	'q'],
			[/^search\.lycos.*/, 		'query'],
			[/^(www\.)?alltheweb.*/, 	'q']	
		]
		
		def search_terms
			@search_terms ||= begin
				term = nil
				uri = begin
					URI::parse referer 
				rescue URI::InvalidURIError
					nil
				end
				
				if uri and uri.query then
					q = uri.query.split("&").inject({}) {|h, t| v = t.split("=", 2); h[v[0]] = v[1]; h }
					@@search_engines.each do |engine|
						if uri.host.match(engine.first) then
							term = CGI::unescape(q[engine.last])
							break
						end
					end
				end
				term
			end
		end
		
		def referred_by_search_engine?
			search_terms.nil?
		end
		
		def add_search_engine(host_regex, query_param)
			@@search_engines += [host_regex, query_param]
			@search_terms = nil
		end
	end
end
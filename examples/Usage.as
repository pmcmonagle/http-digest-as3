package examples {
	
	import ca.pmcmonagle.net.HTTPDigest;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.display.MovieClip;
	
	public class Usage extends MovieClip {
		
		/** 
		 * Note:
		 * You wouldn't usually hard-code your Username
		 * and Password into the source code. Remember
		 * that AS3 can be decompiled! I suggest creating
		 * some input fields for your users to supply their
		 * credentials. :)
		 */
		private static const AUTH_USR = "HARDCODED USERNAME";
		private static const AUTH_KEY = "HARDCODED PASSWORD";
		
		/** 
		 * @constructor
		 */
		public function Usage() {
			exampleGet();
			examplePost();
		}
		
		/** 
		 * Simple example using HTTP/1.1 GET
		 */
		public function exampleGet():void {
			// Where you would normally use a URLLoader, use the 
			// HTTPDigest class instead; just pass in the Username 
			// and Password when you instantiate it.
			var req:URLRequest = new URLRequest('http://yoururl.com/example/resource');
			var loader:HTTPDigest = new HTTPDigest(AUTH_USR, AUTH_KEY);
			loader.addEventListener(Event.COMPLETE, responseHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.load(req);
			
			return void;
		}
		
		/** 
		 * Simple example using HTTP/1.1 POST
		 */
		public function examplePost():void {
			// Again, we're using a URLRequest and HTTPDigest as if
			// HTTPDigest were a URLLoader. This time, we've added
			// data, method and contentType to the URLRequest first.
			var req:URLRequest = new URLRequest('http://yoururl.com/example/resource');
			req.method = URLRequestMethod.POST;
			req.data = "The body of your request; this could be JSON, or XML or anything!";
			req.contentType = "application/json";
			var loader:HTTPDigest = new HTTPDigest(AUTH_USR, AUTH_KEY);
			loader.addEventListener(Event.COMPLETE, responseHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.load(req);
			
			return void;
		}
		
		/** 
		 * Handles error events from URLLoaders
		 */
		private function errorHandler(e:IOErrorEvent):void {
			e.target.removeEventListener(Event.COMPLETE, responseHandler);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			
			trace("IOError: " + e.toString());
		}
		
		/** 
		 * Handles complete events from URLLoaders.
		 */
		private function responseHandler(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, responseHandler);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			
			trace("Raw Data: "+e.target.data);
		}
		
	}
}

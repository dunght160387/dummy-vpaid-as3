package vn.lowngow.util
{
	import flash.external.ExternalInterface;
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.LocaleID;

	public class Logger
	{
		private var _instanceId:uint;
		private var _debug:Boolean;

		public function Logger(instanceId:uint = 0, debug:Boolean = false)
		{
			this._instanceId = instanceId;
			this._debug = debug;
		}

		public function traceLog(message:String):void
		{
			if (_debug == false) {
				return;
			}
			
			if (ExternalInterface.available) {
				ExternalInterface.call('console.log', '[dummy-vpaid-ad]' + '(' + currentInstance() + ')' + '(' + currentDateTime() + ')' + ' ' +  message);
			}
			
			trace(message);
		}
		
		public function traceObject(o:Object):void
		{
			this.traceLog('tracing object');
			
			for(var key:String in o) {
				this.traceLog('key: ' + key + '; value=' + o[key]);
			}
		}

		private function currentInstance():String
		{
			return 'inst-' + _instanceId;
		}

		private function currentDateTime():String
		{
			var currentDate:Date = new Date();
			var dateTimeFormatter:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);

			dateTimeFormatter.setDateTimePattern("yyyy-MM-dd HH:mm:ss");

			return dateTimeFormatter.format(currentDate);
		}
	}
}
// i'm going to suffer a lot doing this (typed this before doing it)
package hxdiscord.utils;

using StringTools;

/**
	The ISO8601 class for Discord. This is used for Discord's date system
**/
class ISO8601Resolver {
	/**
		Returns an ISO8601 formatted string about the current date
	**/
	public static function getActualISODate():String {
		return DateTools.format(Date.now(),
			"%Y-%m-%dT%H:%M:%S." + Std.string(haxe.Timer.stamp() * 10000)
			.split(".")[1] + "Z"); // I DON'T KNOW IF THIS WORKS FOR JS, I'LL TRY TO FIX IT ONCE I ADD JS SUPPORT
	}

	/**
		Returns an ISO8601 formatted string about the calculated time you want
		@param time Enter the time you wanna calculate (i.e 10m)
		@param returnMilliseconds Whether to return miliseconds or not
	**/
	public static var validParameters = ['s', 'S', 'm', 'M', 'h', 'H', 'd', 'D', 'w', 'W', 'y', 'Y'];

	public static function getCalculatedISODate(time:String, ?returnMilliseconds:Bool):String {
		var dateToReturn:String = "";
		if (!validParameters.contains(time.substr(time.length - 1))) {
			throw "Either you specified an invalid parameter or you didn't specify it";
		} else {
			var lastThing:String = time.split("")[time.split("").length - 1];
			var theOtherParameter:Float = Std.parseFloat(time.split(lastThing)[0]);
			var timeToAddInMS:Float = 0;
			var date:Date = new Date(Date.now().getUTCFullYear(), Date.now().getUTCMonth(), Date.now().getUTCDate(), Date.now().getUTCHours(),
				Date.now().getUTCMinutes(), Date.now().getUTCSeconds());
			switch (lastThing.toLowerCase()) {
				case "s" | 'S': // seconds i think
					timeToAddInMS = 1000;
				case "M": // minutes
					timeToAddInMS = 60000;
				case "h" | 'H':
					timeToAddInMS = 3600000;
				case "d" | 'D':
					timeToAddInMS = 86400000;
				case "w" | 'W':
					timeToAddInMS = 24 * 60 * 60 * 1000;
				case "m": // months
					timeToAddInMS = 2629800000;
				case "y" | 'Y':
					timeToAddInMS = 2629800000 * 12;
			}
			if (returnMilliseconds) {
				dateToReturn = DateTools.format(DateTools.delta(date, timeToAddInMS * theOtherParameter),
					"%Y-%m-%dT%H:%M:%S." + Std.string(haxe.Timer.stamp() * 10000).split(".")[1] + "Z");
			} else {
				dateToReturn = DateTools.format(DateTools.delta(date, timeToAddInMS * theOtherParameter), "%Y-%m-%dT%H:%M:%S.000Z");
			}
		}
		return dateToReturn;
	}
}

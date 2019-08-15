package amqp;

import js.lib.Promise;
import haxe.Constraints;
import amqp.AmqpChannel;

@:jsRequire('amqp-connection-manager')
extern class AmqpConnectionManager {
	static function connect(hosts:Array<String>, ?options:ConnectOptions):AmqpConnectionManager;
	function createChannel(options:CreateChannelOptions):AmqpChannelWrapper;
	function isConnected():Bool;
	function close():Void;
	function on(event:String, callback:Function):Void;
	function once(event:String, callback:Function):Void;
}

extern class AmqpChannelWrapper extends AmqpChannelBase {
	function on(event:String, callback:Function):Void;
	function publish(exchange:String, routingKey:String, content:AmqpBuffer, ?options:AmqpPublishOptions, ?callback:AmqpError->{}->Void):Promise<Bool>;
	function sendToQueue(queue:String, content:AmqpBuffer, ?options:{}, ?callback:AmqpError->{}->Void):Promise<Bool>;
	function waitForConfirms():Promise<{}>;
	function addSetup(setup:Setup):Void;
	function removeSetup(setup:Setup, teardown:Teardown):Void;
}

typedef Setup = AmqpConfirmChannel->Promise<Any>;
typedef Teardown = AmqpConfirmChannel->Promise<Any>;

typedef CreateChannelOptions = {
	?name:String,
	?json:Bool,
	?setup:Setup
}
typedef ConnectOptions = {
	?heartbeatIntervalInSeconds:Int,
	?reconnectTimeInSeconds:Int,
	?findServers:Function,
	?connectionOptions:{},
}
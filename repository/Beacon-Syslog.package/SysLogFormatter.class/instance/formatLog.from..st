format
formatLog: aLog from: aLogger
	"timestamp is rounded because the syslog format has only second precision"
	| stream  |
	stream := MultiByteBinaryOrTextStream on: ByteArray new.
			
	stream ascii.
	"write priority"
	self writePriority: (aLogger facility + aLog level severity) on: stream.
	"write header consisting of timestamp and host"
	self writeTimestamp: aLog timestamp on: stream.
	stream
		nextPut:     Character space;
		nextPutAll:  aLogger hostName;
		nextPut:     Character space.
	"syslog format ends here. Now we write the message part"
	self writeMessageFrom: aLog on: stream.
	stream position: 0.
	^ stream upToEnd
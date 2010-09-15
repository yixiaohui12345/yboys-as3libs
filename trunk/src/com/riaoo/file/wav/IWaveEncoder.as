package com.riaoo.file.wav
{
	import flash.utils.ByteArray;

	public interface IWaveEncoder
	{
		function encode(samples:ByteArray, channels:int = 2, bits:int = 16, rate:int = 44100):ByteArray;
	}
}
package com.riaoo.file.wav
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * wav 音频格式编码器。把原始的音频数据编码为 wav 格式的文件。
	 * <br />
	 * 通常，此类用于把麦克风录音后的原始音频数据编码为 wav 文件。
	 * @author Y.Boy
	 * 
	 */	
	public class WaveEncoder implements IWaveEncoder
	{
		private static const RIFF:String = "RIFF";	
		private static const WAVE:String = "WAVE";	
		private static const FMT:String = "fmt ";	
		private static const DATA:String = "data";	
		
		private var _bytes:ByteArray;
		private var _buffer:ByteArray;
		private var _volume:Number;
		
		/**
		 * 
		 * @param volume 音量
		 * 
		 */		
		public function WaveEncoder(volume:Number = 1)
		{
			_bytes = new ByteArray();
			_buffer = new ByteArray();
			_volume = volume;
		}
		
		/**
		 * 开始把原始的音频数据进行编码。
		 * @param samples
		 * @param channels
		 * @param bits
		 * @param rate
		 * @return 
		 * 
		 */		
		public function encode(samples:ByteArray, channels:int = 2, bits:int = 16, rate:int = 44100):ByteArray
		{
			var data:ByteArray = create(samples);
			
			_bytes.length = 0;
			_bytes.endian = Endian.LITTLE_ENDIAN;
			
			_bytes.writeUTFBytes(WaveEncoder.RIFF);
			_bytes.writeInt( uint(data.length + 44) );
			_bytes.writeUTFBytes(WaveEncoder.WAVE);
			_bytes.writeUTFBytes(WaveEncoder.FMT);
			_bytes.writeInt( uint(16) );
			_bytes.writeShort( uint(1) );
			_bytes.writeShort(channels);
			_bytes.writeInt(rate);
			_bytes.writeInt( uint( rate * channels * (bits >> 3) ) );
			_bytes.writeShort( uint( channels * (bits >> 3) ) );
			_bytes.writeShort(bits);
			_bytes.writeUTFBytes(WaveEncoder.DATA);
			_bytes.writeInt(data.length);
			_bytes.writeBytes(data);
			_bytes.position = 0;
			
			return _bytes;
		}
				
		private function create(bytes:ByteArray):ByteArray
		{
			_buffer.endian = Endian.LITTLE_ENDIAN;
			_buffer.length = 0;
			bytes.position = 0;
			
			while(bytes.bytesAvailable)
			{
				_buffer.writeShort( bytes.readFloat() * (0x7fff * _volume) );
			}
			
			return _buffer;
		}
	}
}
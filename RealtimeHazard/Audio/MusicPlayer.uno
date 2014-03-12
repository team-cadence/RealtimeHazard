using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;
using Uno.Platform;
using Experimental.ApiBindings.WebAudio;
using Experimental.Audio;
using Uno.Designer;

namespace RealtimeHazard
{

		public class MusicPlayer : Node
		{
			public Animation MainAnimation
			{
				get { return _mainAnimation; }
				set
				{
					if (_mainAnimation != value)
					{
						if (_mainAnimation != null)
						{
							_mainAnimation.Started -= OnAnimStarted;
							_mainAnimation.Stopped -= OnAnimStopped;
						}
						_mainAnimation = value;
						_mainAnimation.Started += OnAnimStarted;
						_mainAnimation.Stopped += OnAnimStopped;
					}
				}
			}

			public byte[] RawFreqData
			{
				get { return _freqData; }
			}

			public int FrequenzyBinCount
			{
				get { return (int)_analyzer.FrequencyBinCount; }
			}

			private AudioContext _context;
			private AnalyserNode _analyzer;
			private GainNode _gainNode;
			private MediaElementAudioSourceNode _source;
			private HttpStreamSourceNode _stream;
			private byte[] _freqData;

			private BundleFile _music;

			private Sound _sound;
			private Channel _channel;

			private Animation _mainAnimation;
			
			private List<String> tracks = new List<String>()
			{
				"crayons.mp3",
				"rhcp-snow.mp3",
				"Philter-Untitled.mp3",
				"Philter-Pi.mp3",
				"Philter-The-Lounge.mp3"
			};
			
			private int trackIndex = 0;
			
			private const String path = "Z:/Uno/hackaton/RealtimeHazard/RealtimeHazard/Assets/";
			
			public MusicPlayer()
			{
				_music = import BundleFile("../Assets/Philter-Untitled.mp3");

				if (defined(Designer))
				{
					_sound = new Sound(_music.Name);
					_channel = _sound.Play();
					_channel.Pause();
					_channel.Positon = 0.0;
				}
				else
				{
					InitWebAudio();
				}
			}
			
			private void OnAnimStarted()
			{
				_channel.Play();
				_channel.Positon = MainAnimation.CurrentTime;
			}

			private void OnAnimStopped()
			{
				_channel.Pause();
			}

			private void InitWebAudio()
			{
				_context = new AudioContext();
				InitAnalyzer();
				InitGain();
				LoadSourceAndConnect(tracks[trackIndex]);
			}

			private void LoadSourceAndConnect(String track)
			{
				_stream = new HttpStreamSourceNode(path + track);
				_source = _context.CreateMediaElementSourceNode(_stream);

				_source.Connect(_analyzer);
				_analyzer.Connect(_gainNode);
				_gainNode.Connect(_context.Destination);
				_stream.Play();
			}

			private void InitAnalyzer()
			{
				_analyzer = _context.CreateAnalyserNode();
				_analyzer.MinDecibels = -100f;
				_analyzer.MaxDecibels = -10;
				_analyzer.FftSize = 128;
				_analyzer.SmoothingTimeConstat = 0.5;
				_freqData = new byte[(int)_analyzer.FrequencyBinCount];
			}

			private void InitGain()
			{
				_gainNode = _context.CreateGainNode();
				_gainNode.Gain.Value = 1.0f;
			}

			public void Start()
			{
				if (!defined(Designer))
				{
					_stream.Play();
				}
				
			}
			
			public bool HasAudioEnded()
			{
				return _stream.CurrentTime >= _stream.Duration;
			}
			
			public void Update()
			{
				
				if(HasAudioEnded())
				{
					if(trackIndex <= tracks.Count - 1)
					{
						trackIndex++;
					}
					else
					{
						trackIndex = 0;
					}
					LoadSourceAndConnect(tracks[trackIndex]);
				}
			}
			
			protected override void OnUpdate()
			{

				if (!defined(Designer))
				{
					_analyzer.GetByteFrequencyData(_freqData);
				}
				
				
				base.OnUpdate();
			}
		}

}
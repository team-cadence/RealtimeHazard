using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;

namespace RealtimeHazard
{
	public class MusicController : Node
	{
		public MusicPlayer MusicPlayer { get; set; }
		
		protected override void OnInitialize()
		{
			base.OnInitialize();
			PlayTrack();
		}

		
		public void PlayTrack()
		{
			if(MusicPlayer == null) return;

			MusicPlayer.Start();
		}
		
		protected override void OnUpdate()
		{
			MusicPlayer.Update();
			base.OnUpdate();
		}


	}
}
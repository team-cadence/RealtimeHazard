using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Scenes.Primitives;
using Uno.Content;
using Uno.Content.Models;
using Uno.Platform;
using Uno.Designer;

namespace RealtimeHazard
{
	public class Player : Entity
	{
		
		[Range(1, 10)]
		public float Speed { get; set; }
		[Range(0, 100), DesignerName("Size")]
		public float PlayerSize { get; set; }
		
		private float2 newPosition;
		
		public Player()
		{
			PlayerSize = 10;
			Speed = 1;
			Application.Current.Window.KeyDown += OnKeyDown;
		}
		
		protected override void OnInitialize()
		{
			newPosition = Transform.Position.XY;
		}
		
		protected override void OnUpdate()
		{
			Transform.Position = float3(newPosition, 0);
		}

		
		protected override void OnDraw()
		{
			draw DefaultShading, Cube
			{
				Translation: Transform.Position;
				Size: PlayerSize;
			};
		}
		
		protected void OnKeyDown(object sender, Uno.Platform.KeyEventArgs args)
		{
			
			if(args.Key == Key.W)
			{
				MoveUp();
			}
			if(args.Key == Key.S)
			{
				MoveDown();
			}
			if(args.Key == Key.A)
			{
				MoveLeft();
			}
			if(args.Key == Key.D)
			{
				MoveRight();
			}
			
		}

		
		public void MoveUp()
		{
			newPosition += float2(0, Speed);
		}
		
		public void MoveDown()
		{
			newPosition -= float2(0, Speed);
		}
		
		public void MoveLeft()
		{
			newPosition -= float2(Speed, 0);
		}
		
		public void MoveRight()
		{
			newPosition += float2(Speed, 0);
		}
		
	}
}
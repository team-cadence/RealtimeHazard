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

		//public Uno.Geometry.Box Box { get; set; }
		
		public GameBounds Bounds { get; set; }
		
		private float2 newPosition;
		
		

		public Player()
		{
			PlayerSize = 10;
			Speed = 1;
			
		}

		protected override void OnInitialize()
		{
			newPosition = Transform.Position.XY;
			//Box = new Uno.Geometry.Box();
		}

		protected override void OnUpdate()
		{
			Transform.Position = float3(newPosition, 0);
			
			if(Input.IsKeyDown(Key.W))
			{
				MoveUp();
			}
			if(Input.IsKeyDown(Key.A))
			{
				MoveLeft();
			}
			if(Input.IsKeyDown(Key.S))
			{
				MoveDown();
			}
			if(Input.IsKeyDown(Key.D))
			{
				MoveRight();
			}
			
		}


		protected override void OnDraw()
		{
			draw DefaultShading, Cube
			{
				Translation: Transform.Position;
				Size: PlayerSize;
			};
		}

		public void MoveUp()
		{
			if(Bounds != null)
			{
				//if(if (Uno.Geometry.Collision.BoxContainsBox(boundingBox, Box) != Collision.ContainmentType.Contains))
			}
			
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
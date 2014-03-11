using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Scenes.Designer;
using Uno.Scenes.Primitives;
using Uno.Content;
using Uno.Content.Models;

namespace RealtimeHazard
{
	public class Player : Entity
	{
		public float3 Position { get; set; }

		[Range(-2.5f, 2.5f, 3)]
		public float Speed { get; set; }

		[Color]
		public float3 Color { get; set; }

		public Player()
		{
			Position = float3(0);
			Speed = 0f;
		}

		protected override void OnUpdate()
		{
			Transform.Position = Position;
		}

		protected override void OnDraw()
		{
			draw DefaultShading, Sphere
			{
				Translation: Position;
				DiffuseColor: Color;
			};
		}
	}
}
using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;
using Uno.Designer;

namespace RealtimeHazard
{
	public class GameBounds : Entity
	{
		[Range(0, 1000)]
		public float Width { get; set; }
		[Range(0, 1000)]
		public float Height { get; set; }
		[Range(0, 100)]
		public float VisibleDepth { get; set; }

		public float2 SizeAsFloat2
		{
			get { return float2(Width, Height) * 2f; }
		}

		protected override void OnUpdate()
		{
			Transform.Position = float3(0);
		}

		public float3 GetMax()
		{
			return float3(0 - (Width / 2), 0 + (Height / 2), 0);
		}

		public float3 GetMin()
		{
			return float3(0 + (Width / 2), 0 - (Height / 2), VisibleDepth);
		}
		
		public bool Contains(float3 position)
		{
			if(position.X > Width || position.X <  0 - Width)
			{
				return false;
			}

			if(position.Y > Height || position.Y <  0 - Height)
			{
				return false;
			}

			return true;	
		}

		protected override void OnDraw()
		{

			draw DefaultShading, Uno.Scenes.Primitives.WireCube
			{
				Translation: Transform.Position;
				Scale: float3(Width, Height, VisibleDepth);
			};

			base.OnDraw();
		}

	}
}
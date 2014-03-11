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

	public class Enemy : Entity
	{
		
		[Color]
		public float3 Color { get; set; }
		
		protected override void OnUpdate()
		{
			
			Transform.Position = float3(Transform.Position.XY, 0);
			
			base.OnUpdate();
		}

		
		
		protected override void OnDraw()
		{
			
			draw DefaultShading, Cube
			{
				Translation: Transform.Position;
				DiffuseColor: Color;
			};
			
			base.OnDraw();
		}
		
		protected void Destroy()
		{
			// Create animation to destroy enemy
		}

		
	}
}
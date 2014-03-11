using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Geometry;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;
using Uno.Platform;

namespace RealtimeHazard
{
	public class PointerTarget : Entity
	{
		
		public PointerTarget()
		{
		}
		
		protected override void OnUpdate()
		{
			var ray = Context.Camera.Frustum.PixelToWorldRay(Input.PointerCoord, Context.VirtualResolution);
			Transform.Position = float3(ray.Position.X * 1000, ray.Position.Y * 1000, 0);
			debug_log ray.Position;
			base.OnUpdate();
		}
		
		protected override void OnDraw()
		{
			
			draw DefaultShading, Uno.Scenes.Primitives.Sphere
			{
				Translation: Transform.Position;
				Radius: 5f;
			};
			
			base.OnDraw();
		}

		
	}
}
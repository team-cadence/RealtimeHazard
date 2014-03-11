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
		public GameCamera Camera { get; set; }

		public PointerTarget()
		{

		}

		protected override void OnUpdate()
		{
			if(Camera == null) return;

			var ray = Context.Camera.Frustum.PixelToWorldRay(Input.PointerCoord, Context.VirtualResolution);
			Transform.Position = float3(ray.Position.X * Camera.Distance, ray.Position.Y * Camera.Distance, 0);

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
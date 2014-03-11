using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;

namespace RealtimeHazard
{
	public class PointerTarget : Entity
	{
		protected override void OnPointerMove(Uno.Scenes.PointerMoveArgs args)
		{
			base.OnPointerMove(args);
			this.Transform.Position = float3(args.PointCoord, 0);
		}
	}
}
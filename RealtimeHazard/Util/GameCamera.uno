using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;
using Uno.Designer;

namespace RealtimeHazard
{
	public class GameCamera : Entity
	{
		[Range(0, 1000)]
		public float Distance { get; set; }

		public GameCamera()
		{
			Distance = 100f;
		}

		protected override void OnUpdate()
		{
			Transform.Position = float3(0, 0, Distance);

			base.OnUpdate();
		}

	}
}
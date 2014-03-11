using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;

namespace RealtimeHazard
{
	public class Projectile : GameObject
	{
		public float3 StartPosition { get; set; }
		public float2 Direction { get; set; }
		public float Speed { get; set; }
		public bool IsPlayerProjectile { get; set; }
		
		public Projectile()
		{
			IsPlayerProjectile = true;
		}
		
		protected override void OnUpdate()
		{
			Transform.Position += float3(Vector.Normalize(Direction) * Speed, 0);
			
			base.OnUpdate();
		}

		protected void OnImpact()
		{
			
		}
		
	}
}
using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;
using Uno.Geometry;

namespace RealtimeHazard
{
	public class Projectile : GameObject
	{
		public float2 Direction { get; set; }
		public float Speed { get; set; }
		public bool IsPlayerProjectile { get; set; }

		public float3 Position { get; set; }

		public Projectile()
		{
			IsPlayerProjectile = true;
			Position = float3(0);
		}

		public Projectile(float3 initialPosition, float2 direction) :
			this(initialPosition, direction, true)
		{
		}

		public Projectile(float3 initialPosition, float2 direction, bool isPlayerProjectile) :
			this(initialPosition, direction, isPlayerProjectile, 3f)
		{
		}

		public Projectile(float3 initialPosition, float2 direction, bool isPlayerProjectile, float speed)
		{
			Direction = direction;
			Speed = speed;
			IsPlayerProjectile = isPlayerProjectile;
			Position = initialPosition;
		}

		protected override void OnInitialize()
		{
			base.OnInitialize();
		}


		public void Update()
		{
			Position += float3(Vector.Normalize(Direction) * Speed, 0);
			Position = float3(Position.XY, 20);

		}

		public void Draw()
		{
			draw DefaultShading, Uno.Scenes.Primitives.Sphere
			{
				Radius: 3f;
				DiffuseColor: float3(0);
				Translation: Position;
			};

		}

		protected void OnImpact()
		{

		}

		public override void Destroy()
		{
		}
	}
}
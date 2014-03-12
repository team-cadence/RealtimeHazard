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
		public float3 StartPosition { get; set; }
		public float2 Direction { get; set; }
		public float Speed { get; set; }
		public bool IsPlayerProjectile { get; set; }

		private float3 position;

		public Projectile()
		{
			IsPlayerProjectile = true;
			position = float3(0);
		}

		public Projectile(float3 startPosition, float2 direction)
		{
			StartPosition = startPosition;
			Direction = direction;
			Speed = 3f;
			IsPlayerProjectile = true;
			position = StartPosition;
		}

		public Projectile(float3 startPosition, float2 direction, bool isPlayerProjectile)
		{
			StartPosition = startPosition;
			Direction = direction;
			Speed = 3f;
			IsPlayerProjectile = isPlayerProjectile;
			position = StartPosition;
		}

		public Projectile(float3 startPosition, float2 direction, float speed, bool isPlayerProjectile)
		{
			StartPosition = startPosition;
			Direction = direction;
			Speed = speed;
			IsPlayerProjectile = isPlayerProjectile;
			position = StartPosition;
		}

		protected override void OnInitialize()
		{

			base.OnInitialize();
		}


		public void Update()
		{
			position += float3(Vector.Normalize(Direction) * Speed, 0);

		}

		public void Draw()
		{
			draw DefaultShading, Uno.Scenes.Primitives.Sphere
			{
				Radius: 3f;
				DiffuseColor: float3(0);
				Translation: position;
			};

		}
		
		public bool IsWithinBounds(Uno.Geometry.Box Box)
		{
			return Uno.Geometry.Collision.BoxContainsSphere(Box, new Sphere(position, 3f)) == Uno.Geometry.Collision.ContainmentType.Contains;
		}
		
		protected void OnImpact()
		{

		}

	}
}
using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;
using Uno.Platform;

namespace RealtimeHazard
{
	public class GameManager : Node
	{

		public Player Player { get; set; }
		public PointerTarget Target { get; set; }

		public List<Enemy> Enemies { get; set; }
		public List<Projectile> Projectiles { get; set; }
		public GameBounds Bounds { get; set; }

		public GameManager()
		{
			Projectiles = new List<Projectile>();
			Enemies = new List<Enemy>();
		}
		
		public static bool IsWithinBounds(GameBounds bounds, float3 position)
		{
			if(position.X > bounds.Width || position.X <  0 - bounds.Width)
			{
				return false;
			}
			
			if(position.Y > bounds.Height || position.Y <  0 - bounds.Height)
			{
				return false;
			}
			
			return true;
		}

		protected void OnPointerDown(object sender, Uno.Platform.PointerEventArgs args)
		{

		}

		protected override void OnFixedUpdate()
		{
			if(Player == null) return;
			
			if (Input.IsPointerDown())
			{
				AddPlayerProjectile();
			}
			
			foreach (var projectile in Projectiles)
			{	
				UpdateProjectile(projectile);
			}
			
			base.OnFixedUpdate();
		}

		protected override void OnDraw()
		{
			foreach (var projectile in Projectiles)
			{
				projectile.Draw();
			}

			/*if(Enemies.Count > 0)
				foreach (var e in Enemies)
					e.OnDraw();*/

			base.OnDraw();
		}

		// Taco
		private void AddPlayerProjectile()
		{
			AddProjectile(true);
		}
		
		private void AddEnemyProjectile()
		{
			AddProjectile(false);
		}

		private void AddProjectile(bool isPlayerProjectile)
		{
			var initialPosition = float3(Player.Transform.Position.XY, 0);
			var direction = Vector.Normalize(Target.Transform.Position.XY - Player.Transform.Position.XY);
			var speed = 10f;
			
			var newProjectile = new Projectile(initialPosition, direction, isPlayerProjectile, speed);
			
			Projectiles.Add(newProjectile);
		}
		
		private void UpdateProjectile(Projectile projectile)
		{
			projectile.Update();

			if(!IsWithinBounds(Bounds, projectile.Position))
			{
				Projectiles.Remove(projectile);
			}
		}
	}
}
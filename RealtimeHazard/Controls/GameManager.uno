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
		
		public CollisionGrid collisionGrid { get; set; }
		
		public List<GameObject> AllGameObjects
		{
			get
			{
				var list = new List<GameObject>();
				
				list.Add(Player);
				
				foreach (var enemy in Enemies)
				{
					list.Add(enemy);
				}
				
				foreach (var projectile in Projectiles)
				{
					list.Add(projectile);	
				}
				
				return list;
			}
		}

		public GameManager()
		{
			Projectiles = new List<Projectile>();
			Enemies = new List<Enemy>();
			collisionGrid = new CollisionGrid();
		}

		protected void OnPointerDown(object sender, Uno.Platform.PointerEventArgs args)
		{

		}

		protected override void OnFixedUpdate()
		{
			if(Player == null)
			{
				debug_log "Player was null";
				return;
			}
			
			if (collisionGrid.IndexOf(Player) == -1)
			{
				debug_log "placing player in correct bucket";
				collisionGrid.PlaceInCorrectBucket(Player);	
			}
			
			collisionGrid.PrintAllBuckets();
			
			debug_log "Player bucket index: " + collisionGrid.IndexOf(Player);

			if (Input.IsPointerDown())
			{
				AddPlayerProjectile();
			}

			for (int i = 0; i < Projectiles.Count; i++)
			{
				var projectile = Projectiles[i];
				
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

			if(!Bounds.Contains(projectile.Position))
			{
				Projectiles.Remove(projectile);
			}
		}
	}
}
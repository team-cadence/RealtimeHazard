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
			//Application.Current.Window.PointerDown += OnPointerDown;
		}

		protected void OnPointerDown(object sender, Uno.Platform.PointerEventArgs args)
		{

		}

		protected override void OnUpdate()
		{
			if(Player == null) return;
			if (Input.IsPointerDown())
			{
				Projectiles.Add(
					new Projectile(
						Player.Transform.Position,
						Vector.Normalize(Target.Transform.Position.XY - Player.Transform.Position.XY),
						10f,
						true
					)
				);
			}

			if(Projectiles.Count > 0)
				for (int i = 0; i < Projectiles.Count; i++)
				{	
					Projectiles[i].Update();
					if(Projectiles[i].IsWithinBounds(new Uno.Geometry.Box(Bounds.GetMin(), Bounds.GetMax())))
					{
						//Projectiles[i].Update();
					}
					else
					{
						//Projectiles.RemoveAt(i);
					}
				}
			
				debug_log Projectiles.Count;
				
			/*if(Enemies.Count > 0)
				foreach (var e in Enemies)
					e.Update();*/

			base.OnUpdate();
		}

		protected override void OnDraw()
		{

			if(Projectiles.Count > 0)
				foreach (var p in Projectiles)
					p.Draw();

			/*if(Enemies.Count > 0)
				foreach (var e in Enemies)
					e.OnDraw();*/

			base.OnDraw();
		}




	}
}
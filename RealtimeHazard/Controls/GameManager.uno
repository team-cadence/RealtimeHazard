using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;

namespace RealtimeHazard
{
	public class GameManager : Node
	{
		public List<Enemy> Enemies { get; set; }
		public List<Projectile> Projectiles { get; set; }
	
		public GameManager()
		{
			
		}
		
		protected override void OnPointerDown(Uno.Scenes.PointerDownArgs args)
		{
			base.OnPointerDown(args);
		}

		
	}
}
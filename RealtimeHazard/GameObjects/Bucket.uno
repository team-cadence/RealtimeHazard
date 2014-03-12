using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;

namespace RealtimeHazard
{
	public class Bucket
	{
		public float2 Position { get; set; }

		public float2 Size { get; set; }
		
		public List<GameObject> AllGameObjects
		{
			get { return gameObjects; }
		}

		private List<GameObject> gameObjects;

		public Bucket(float2 position, float2 size)
		{
			this.Position = position;
			this.Size = size;
		}

		public void AddGameObject(GameObject o)
		{
			gameObjects.Add(o);
		}

		public void RemoveGameObject(GameObject o)
		{
			gameObjects.Remove(o);
		}

		public bool Contains(GameObject o)
		{
			return gameObjects.Contains(o);
		}
	}
}
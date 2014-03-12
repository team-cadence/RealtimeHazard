using Uno;
using Uno.Collections;
using Uno.Designer;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Scenes.Primitives;
using Uno.Content;
using Uno.Content.Models;

namespace RealtimeHazard
{
	public class CollisionGrid : Entity
	{
		[Range(1, 20)]
		public int Rows { get; set; }

		[Range(1, 20)]
		public int Columns{ get; set; }

		public float2 TotalGridSize { get; set; }

		private Bucket[] buckets;

		public CollisionGrid()
		{
			buckets = new Bucket[Rows * Columns];
			Rows = Columns = 8;
		}

		public void PlaceInCorrectBucket(GameObject gameObject)
		{
			float smallestDistance = float.MaxValue;

			Bucket currentBucket = null;
			Bucket closestBucket = null;

			foreach (var bucket in buckets)
			{
				if (bucket.Contains(gameObject))
				{
					currentBucket = bucket;
				}

				var distanceToBucketSquared = Vector.LengthSquared(gameObject.Transform.Position - float3(bucket.Position.XY, 0));
				if (distanceToBucketSquared < smallestDistance)
				{
					smallestDistance = distanceToBucketSquared;
					closestBucket = bucket;
				}
			}

			// Switch buckets if necessary
			if (closestBucket != currentBucket)
			{
				currentBucket.RemoveGameObject(gameObject);
				closestBucket.AddGameObject(gameObject);
			}
		}

		public int IndexOf(GameObject gameObject)
		{
			for (int i = 0; i < buckets.Length; i++)
			{
				var bucket = buckets[i];

				if (bucket.Contains(gameObject))
				{
					return i;
				}
			}

			// wtf, this should never happen.
			return -1;
		}

		public void PrintAllBuckets()
		{
			foreach (var bucket in buckets)
			{
				debug_log bucket.AllGameObjects;
			}
		}

		protected override void OnDraw()
		{
			var quadSize = float2(TotalGridSize.X / Rows, TotalGridSize.Y / Columns);
			var offset = float2(-TotalGridSize.X / 2, -TotalGridSize.Y / 2);

			for (int row = 0; row < Rows; row++)
			{
				for (int col = 0; col < Columns; col++)
				{
					var position = float3(row * quadSize.X, col * quadSize.Y, 0);

					draw DefaultShading, Quad
					{
						PrimitiveType: Uno.Graphics.PrimitiveType.LineStrip;

						DiffuseColor: float3(1, 0, 1);
						Size: quadSize;
						Translation: position + float3(offset.XY, 0);
					};
				}
			}
		}
	}
}
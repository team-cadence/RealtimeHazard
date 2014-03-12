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
		
		public float2 Size { get; set; }
		
		public CollisionGrid()
		{
			Rows = Columns = 4;
		}
		
		protected override void OnDraw()
		{
			var quadSize = float2(Size.X / Columns, Size.Y / Rows);
			
			for (int row = 0; row < Rows; row++)
			{
				for (int col = 0; col < Columns; col++)
				{
					var position = float3(row * quadSize.X, col * quadSize.Y, 0);
					
					draw DefaultShading, Quad
					{
						PrimitiveType: Uno.Graphics.PrimitiveType.LineStrip;
						
						DiffuseColor: float3(1, 0, 0);
						Size: quadSize;
						Translation: position;
					};
				}
			}
		}


	}
}